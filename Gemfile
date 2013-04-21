# -*- ruby -*-

java = RUBY_PLATFORM =~ /java/
macruby = defined?(RUBY_ENGINE) && RUBY_ENGINE == "macruby"

source "https://rubygems.org"

require 'uri'
require 'open-uri'

if !java && !macruby
  gem 'ffi', '~>1.1.5'
end

if !java
  gem 'rmagick', git:"git://github.com/smparkes/rmagick.git"
end

gemspec
