# -*- ruby -*-

java = RUBY_PLATFORM =~ /java/
macruby = defined?(RUBY_ENGINE) && RUBY_ENGINE == "macruby"

source "https://rubygems.org"

if !java && !macruby
  gem 'ffi', '~>1.1.5'
end

if !java
  gem 'rmagick'
end

gemspec
