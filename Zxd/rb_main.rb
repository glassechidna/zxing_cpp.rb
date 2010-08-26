$:.unshift NSBundle.mainBundle.resourcePath.fileSystemRepresentation
begin
  framework "AppKit"
  require 'lib/application'
rescue Exception => e
  STDERR.puts e.message
  e.backtrace.each { |bt| STDERR.puts bt }
end
