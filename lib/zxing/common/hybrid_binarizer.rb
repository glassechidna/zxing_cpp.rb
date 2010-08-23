module ZXing; end
module ZXing::Common; end

module ZXing::Common::HybridBinarizer
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Common::HybridBinarizer
  else
    if defined? RUBY_ENGINE and RUBY_ENGINE == "macruby"
      Class = ZXing::ObjC::Common::HybridBinarizer
    else
      Class = ZXing::FFI::Common::HybridBinarizer
    end
  end

  def self.new *args
    if self == ZXing::Common::HybridBinarizer
      Class.new(*args)
    else
      super
    end
  end

  def initialize *args
    super *args
  end

end
