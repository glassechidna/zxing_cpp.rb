# -*- ruby -*-

java = RUBY_PLATFORM =~ /java/
macruby = defined?(RUBY_ENGINE) && RUBY_ENGINE == "macruby"

source "https://rubygems.org"

if !java && !macruby
  gem 'ffi'
end

if !java
  gem 'rmagick'
end

gemspec
