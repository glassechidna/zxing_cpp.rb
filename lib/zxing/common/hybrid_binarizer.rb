module ZXing; end
module ZXing::Common; end

module ZXing::Common::HybridBinarizer
  include ZXing::Binarizer
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Common::HybridBinarizer
  else
    Class = ZXing::FFI::Common::HybridBinarizer
  end

  def self.new *args
    if self == ZXing::Common::HybridBinarizer
      Class.new(*args)
    else
      super
    end
  end
end
