# -*- ruby -*-

require 'rake/clean'

require 'rubygems'

CLEAN.concat Dir["**/*.a"]
CLEAN.concat Dir["**/*.so"]
CLEAN.concat Dir["**/*.bundle"]
CLEAN.concat Dir["**/*.dylib"]
CLEAN.concat Dir["**/*.pyc"]
CLEAN.concat Dir["lib/zxing/Makefile"]
CLEAN.concat Dir["lib/zxing/zxing.o"]
CLEAN.concat Dir["**/build"]

shared_ext = ".so"
Dir["lib/zxing/zxing.*"].each do |file|
  case file
  when %r{\.so$}; shared_ext = ".so"
  when %r{\.dylib$}; shared_ext = ".dylib"
  when %r{\.bundle$}; shared_ext = ".bundle"
  end
end

file "vendor/zxing" do
  sh "git submodule update --init"
end

task :compile => "vendor/zxing"

task :clean do
  if File.exist? "vendor/zxing/cpp/build" 
    Dir.chdir "vendor/zxing/cpp" do
      sh "python scons/scons.py -c"
    end
  end
end

subdirs = []
subdirs += [:aztec, :datamatrix, :negative, :oned]
subdirs += [:qrcode, :pdf417]

file "vendor/zxing/cpp/build/libzxing.a" =>
  Dir["vendor/zxing/cpp/core/src/**/*.{h,cpp}"] do
  Dir.chdir "vendor/zxing/cpp" do
    sh "python scons/scons.py DEBUG=false PIC=yes lib"
  end
end
file "lib/zxing/Makefile" => [ "lib/zxing/extconf.rb",
                               "vendor/zxing/cpp/build/libzxing.a" ] do
  Dir.chdir "lib/zxing" do
    ruby "extconf.rb"
  end
end
file "lib/zxing/zxing#{shared_ext}" => [ "lib/zxing/Makefile",
                                         "lib/zxing/zxing.cc",
                                         "vendor/zxing/cpp/build/libzxing.a" ] do
  sh "cd lib/zxing && make"
end
task :recompile do
  file("vendor/zxing/cpp/build/libzxing.a").execute
  rm_f "lib/zxing/zxing#{shared_ext}"
  file("lib/zxing/zxing#{shared_ext}").execute
end
desc "compile zxing shared library"
task :compile => "lib/zxing/zxing#{shared_ext}"

namespace :zxing do
  namespace :test do
    subdirs.each do |subdir|
      namespace subdir do
        desc "run #{subdir} tests"
        task :run do
          args = [
                  # "ruby", "-Ilib",
                  "test/vendor.rb" ] +
            Dir["vendor/zxing/**/#{subdir}/*BlackBox*TestCase.java"]
          args.unshift "valgrind" if ENV["valgrind"]
          args.unshift "env", "EXPLICIT_LUMINANCE_CONVERSION=true"
          sh args.join(" ")
        end
      end
      desc "compile and run #{subdir} tests"
      task subdir => [ :compile, "test:#{subdir}:run" ]
    end
    task :run => subdirs.map { |subdir| "test:#{subdir}:run" }
  end

  desc "run all the zxing tests (optionally, only those maching [pattern])"
  task :test, [ :pattern ] => :compile do |t, args|
    if args[:pattern]
      args = ["ruby", "-Ilib", "test/vendor.rb", args[:pattern]]
      args.unshift "valgrind" if ENV["valgrind"]
      args.unshift "env", "EXPLICIT_LUMINANCE_CONVERSION=true"
      sh args.join(" ")
    else
      subdirs.each { |subdir| task("zxing:test:#{subdir}:run").execute }
    end
  end
end

task(:default).clear
task :default => :compile
