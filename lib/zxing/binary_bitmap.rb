module ZXing; end

module ZXing::BinaryBitmap
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::BinaryBitmap
  else
    if defined? RUBY_ENGINE and RUBY_ENGINE == "macruby"
      Class = ZXing::ObjC::BinaryBitmap
    else
      Class = ZXing::FFI::BinaryBitmap
    end
  end

  def self.new *args
    if self == ZXing::BinaryBitmap
      Class.new(*args)
    else
      super
    end
  end

  attr_reader :native

  def initialize native
    @native = native
  end
end
