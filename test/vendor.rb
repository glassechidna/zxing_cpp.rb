#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

if ENV["EXPLICIT_LUMINANCE_CONVERSION"] != "true"
  raise "must run tests with EXPLICIT_LUMINANCE_CONVERSION=true in the environment"
end

$:.push File.expand_path(File.join(File.dirname(__FILE__),"../lib"))

if RUBY_VERSION =~ /^1.8/
  $KCODE = "UTF8"
  require 'jcode'
end

require 'rubygems'
require 'zxing'

include ZXing

global_found = 0;
global_must_pass = 0;
global_total_tests = 0;

$stdout.sync = true

files = ARGV

files = files.map do |file|
  if File.exist? file
    file
  else
    files = Dir.glob("vendor/zxing/core/test/{**/*BlackBox*java,data/blackbox/**/*.{png,gif,jpg,jpeg}}",  File::FNM_CASEFOLD)
    files = files.grep Regexp.new(file, true);
  end
end
files.flatten!

@drivers = []

$drivers = {}
$images = Dir.glob("vendor/zxing/core/test/data/**/*.{png,gif,jpg,jpeg}",  File::FNM_CASEFOLD);
Dir["vendor/zxing/core/test/**/*BlackBox*java"].each do |driver|
  text = IO.read driver

  match, dir, optional, reader, args, format, negative = nil

  base = %r{extends\s+(Abstract(.*)BlackBoxTestCase)}.match text
  next if base.nil?

  case base[2]
  when ""
    match, dir, optional, reader, args, format =
      *%r{super\(\s*"(.+)"(\s*,\s*new\s*(.+)\(([^\)]*)\)\s*,\s*BarcodeFormat\.(.+))?\s*\);}.match(text)
  when "Negative"
    match, dir =
      *%r{super\(\s*"(.+)"\s*\);}.match(text)
    reader = "MultiFormatReader"
    args = nil
    format = nil
    negative = true
  else; raise "no runner support for #{base[2]}"
  end

  tests = []

  text.scan %r{addTest\(\s*([^,]+)\s*(,\s*(.+)\s*)?,\s*(.+)\s*\);} do |match|
    normal = match[0].to_i
    harder = nil
    if match[2].nil?
      harder = normal
    else
      harder = match[2].to_i
    end
    rotation = match[3].to_f
    tests.push [normal, harder, rotation]
  end
  
  $drivers[driver] = {
    :dir => dir,
    :reader => reader,
    :args => args,
    :format => format,
    :images => [],
    :all_images => $images.find_all { |image| !image.index("/#{dir}/").nil? },
    :tests => tests,
    :negative => negative
  } if dir
end

def add_driver file, image = nil
  driver = $drivers[file]
  raise file if driver.nil?
  @drivers.push driver unless @drivers.include? driver
  if image.nil?
    driver[:images] = driver[:all_images]
  else
    driver[:images].push image unless driver[:images].include? image
  end
end

def add_image image
  file, hash = $drivers.find do |file, hash|
    image.index hash[:dir]
  end
  if hash
    add_driver file, image
  end
end

files.each do |file|
  add_image file
end

@drivers.each do |driver|
  args = [ :new ]
  if driver[:args] && driver[:args] !~ /^\s*$/
    driver[:args].split(",").each do |arg|
      case arg
      when /^\s*true\s*$/
        args.push true
      when /^\s*false\s*$/
        args.push false
      else
        raise "implement reader argument for #{arg}"
      end
    end
  end

  case driver[:reader]
  when "DataMatrixReader"; reader = ZXing::DataMatrix::DataMatrixReader
  when "AztecReader"; reader = ZXing::Aztec::AztecReader
  when "Code39Reader"; reader = ZXing::OneD::Code39Reader
  else; reader = ZXing.const_get(driver[:reader])
  end

  reader = reader.send(*args)

  passed = []
  tried_harder = []

  driver[:images].sort.each do |filename|
    puts "Starting #{filename}"

    image = Image.read filename
    if !driver[:negative]    
      expected_filename = Dir[filename.sub(%r{\.[^.]+$}, "")+".{txt,bin}"].first
      if !expected_filename.index(".bin").nil?
        expected_text = File.open(expected_filename, "r:binary") do |f|
          f.read
        end
      elsif RUBY_VERSION !~ /^1.8/
        expected_text = File.open(expected_filename, "r:utf-8") do |f|
          f.read
        end
      else
        expected_text = IO.read expected_filename
      end
    end

    expected_metadata = {}
    Dir[filename.sub(%r{\.[^.]+$}, ".metadata.txt")].each do |metafile|
      File.open(metafile).each do |line|
        pair = line.split("=")
        expected_metadata[pair.first] = pair.last
      end
    end

    driver[:tests].each_with_index do |params, test|
      passed[test] = passed[test] || 0
      tried_harder[test] = tried_harder[test] || 0
      mustPass, tryHarder, rotation = *params
      rotated = image.rotate rotation
      source = LuminanceSource.new rotated
      binarizer = Common::HybridBinarizer.new source
      bitmap = BinaryBitmap.new binarizer

      time = Time.now

      decode = lambda do |try_harder|
        suffix = "(#{try_harder ? 'try harder, ' : ''}rotation: #{rotation})"
        result = nil
        hints = {}
        if try_harder
          hints[:try_harder] = true
        end
        # hardcode for now ...
        if driver[:format] == "PDF417"
          hints[:possible_formats] = [:PDF417]
        end
        if driver[:format] == "DATA_MATRIX"
          hints[:possible_formats] = [:DATA_MATRIX]
        end
        begin
          result = reader.decode bitmap, hints
          print_time = false
          print_time and p [Time.now - time, try_harder, rotation]
          if driver[:negative]
            printf("%s false positive: '%s' with format '%s' (rotation: %d)\n",
                   try_harder ? "Try harder found" : "Found",
                   result.text,
                   result.format,
                   rotation)
            return true
          end
        rescue NotFoundException => e
          print_time and p [Time.now - time, try_harder, rotation]
          return false if driver[:negative]
          puts [e.class.to_s, e.to_s, suffix].join(" ")
          return false
        rescue ReedSolomonException => e
          print_time and p [Time.now - time, try_harder, rotation]
          return false if driver[:negative]
          puts [e.class.to_s, e.to_s, suffix].join(" ")
          return false
        rescue ReaderException => e
          print_time and p [Time.now - time, try_harder, rotation]
          return false if driver[:negative]
          puts [e.class.to_s, e.to_s, suffix].join(" ")
          return false
        rescue FormatException => e
          print_time and p [Time.now - time, try_harder, rotation]
          return false if driver[:negative]
          puts [e.class.to_s, e.to_s, suffix].join(" ")
          return false
        rescue IllegalArgumentException => e
          print_time and p [Time.now - time, try_harder, rotation]
          return false if driver[:negative]
          puts [e.class.to_s, e.to_s, suffix].join(" ")
          return false
        rescue ChecksumException => e
          print_time and p [Time.now - time, try_harder, rotation]
          return false if driver[:negative]
          puts [e.class.to_s, e.to_s, suffix].join(" ")
          return false
        end
        
        if driver[:format] != result.format
          puts "Format mismatch: expected '#{driver[:format]}' but got '" +
            "#{result.format}' #{suffix}"
          return false;
        end

        result_text = result.text

        # this is a hack, but the expected text assumes the SJIS 0x5c
        # is \ but iconv (correctly?) converts it to ¥
        
        # not sure about this ...
        if expected_text.encoding == Encoding.find("BINARY")
          result_text.force_encoding("BINARY")
        elsif RUBY_VERSION =~ /^1.[89]/
          result_text.gsub!(/¥/, '\\')
        end

        if expected_text != result_text
          puts "Mismatch: expected '#{expected_text}' but got '#{result_text}' #{suffix}"
          return false;
        end

        result_metadata = result.metadata
        # if metadata isn't supported, the result will be nil
        # if it is supported it should be a possibly empty hash
        if result_metadata
          expected_metadata.each do |key,value|
            if result_metadata[key] != value
              puts "Metadata mismatch: for key '#{key}' expected '#{value}' but got '#{result_metadata[key]}'"
              return false;
            end
          end
        end
        
        return true;
      end
      
      decoded = decode.call false
      passed[test] = passed[test]+1 if decoded
      if !decoded || !driver[:negative]
        decoded = decode.call true
        tried_harder[test] = tried_harder[test]+1 if decoded
      end
    end

  end

  total_found = 0;
  total_did_pass = 0;
  total_must_pass = 0;

  driver[:tests].each_with_index do |params, test|
    mustPass, tryHarder, rotation = *params
    puts "Rotation #{rotation} degrees:"
    if driver[:negative]
      print "  #{passed[test]+tried_harder[test]} of #{2*driver[:images].length} images passed"
      if driver[:images].length == driver[:all_images].length
        print " (#{mustPass} allowed)"
      end
      puts
    else
      print "  #{passed[test]} of #{driver[:images].length} images passed"
      if driver[:images].length == driver[:all_images].length
        print " (#{mustPass} required)"
      end
      puts
      print "  #{tried_harder[test]} of #{driver[:images].length} images passed with try harder"
      if driver[:images].length == driver[:all_images].length
        print " (#{tryHarder} required)"
      end
      puts
    end

    total_found += passed[test]
    total_found += tried_harder[test]
    if driver[:images].length == driver[:all_images].length
      total_did_pass += passed[test]
      total_did_pass += tried_harder[test]
      total_must_pass += mustPass
      if !driver[:negative]
        total_must_pass += tryHarder
      end
    end
  end

  global_found += total_found
  global_must_pass += total_must_pass

  total_tests = driver[:images].length * driver[:tests].length * 2;

  global_total_tests += total_tests

  print "TOTALS:\n  Decoded #{total_found} images out of #{total_tests}" +
    " (#{total_found * 100 / total_tests}%"
  print ", #{total_did_pass} of #{total_must_pass} required"
  puts ") "+driver[:dir]
  if total_did_pass > total_must_pass
    puts "  *** Test too lax by #{total_found - total_must_pass} images"
  elsif total_did_pass < total_must_pass
    puts "  *** Test failed by #{total_must_pass - total_found} images"
  end

end

if ARGV.length > 1
  puts "TOTALS:\n  Decoded #{global_found} images out of #{global_total_tests}" +
    "(#{global_found * 100 / global_total_tests}%, #{global_must_pass} required)"
  if global_found > global_must_pass
    puts "  *** Test too lax by #{global_found - global_must_pass} images"
  elsif global_found < global_must_pass
    puts "  *** Test failed by #{global_must_pass - global_found} images"
  end
end

diff = 0
if global_found < global_must_pass
  diff = global_must_pass - global_found
  if diff > 0
    diff = [diff, 255].min
  end
end

exit
