# -*- ruby -*-

java = RUBY_PLATFORM =~ /java/
macruby = defined?(RUBY_ENGINE) && RUBY_ENGINE == "macruby"

source :rubygems

if !java && !macruby
  gem 'ffi'
end

if !java
  gem 'rmagick'
end

gemspec
