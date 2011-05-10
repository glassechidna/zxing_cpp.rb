# -*- mode: ruby; encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'zxing/version'

Gem::Specification.new do |s|
  s.name = "zxing.rb"
  s.version = ZXing::VERSION

  s.authors = ["Steven Parkes"]
  s.email = ["smparkes@smparkes.net"]
  s.description = "An interface to the zxing decoder libraries. Supports zxing java under jruby and zxing C++ under 1.8.7/1.9.2 (and macruby?)."

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.rdoc CHANGELOG.rdoc)
  s.extra_rdoc_files = ["README.rdoc"]

  s.homepage = "http://github.com/smparkes/zxing.rb"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.6"
  s.summary = "Ruby interface to zxing.rb"

  s.add_development_dependency("bundler", "~> 1.0")
end
