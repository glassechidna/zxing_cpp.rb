lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'zxing/version'

GEMSPEC_DIR = File.expand_path('..', __FILE__)

module ZXingCppSpec
  def self.submodule_files
    `git submodule --quiet foreach pwd`.split("\n").inject([]) do |files, submodule_path|
      Dir.chdir(submodule_path) do
        files += `git ls-files -z`.split("\x0").map do |f|
          "#{submodule_path}/#{f}".gsub "#{GEMSPEC_DIR}/", ''
        end
      end
      files
    end
  end
end

Gem::Specification.new do |s|
  s.name = 'zxing_cpp'
  s.version = ZXing::VERSION

  s.authors = ['Benjamin Dobell']
  s.email = ['benjamin.dobell@glassechidna.com.au']
  s.description = 'A barcode and QR code library that works with regular Ruby (not just JRuby). This gem comes bundled with ZXing C++ (zxing-cpp) and interfaces with it using FFI. As such this gem works with most major Ruby distributions.'
  s.licenses = ['MIT', 'Apache-2.0']

  s.homepage = 'https://github.com/glassechidna/zxing_cpp.rb'
  s.summary = 'A barcode and QR code library.'

  s.files = `git ls-files -z`.split("\x0") + ZXingCppSpec.submodule_files
  s.extensions = ['ext/zxing/extconf.rb']
  s.rdoc_options = ['--main', 'README.rdoc']
  s.extra_rdoc_files = ['README.rdoc']
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^test/})
  s.require_paths = ['lib', 'ext']

  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'rake-compiler', '~> 0.9'
  s.add_development_dependency 'shoulda', '~> 3.5'

  s.add_dependency 'ffi', '~> 1.1'
  s.add_dependency 'rmagick', '~> 2.13'
end
