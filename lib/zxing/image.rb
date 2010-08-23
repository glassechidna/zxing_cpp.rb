module ZXing; end

module ZXing::Image

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Image
  else
    if defined? RUBY_ENGINE and RUBY_ENGINE == "macruby"
      Class = ZXing::ObjC::Image
    else
      Class = ZXing::RMagick::Image
    end
  end

  def self.read *args
    Class::read(*args)
  end

  attr_reader :native

  def initialize native
    @native = native
  end

end
