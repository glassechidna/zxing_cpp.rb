module ZXing; end

module ZXing::HybridBinarizer
  include ZXing::Binarizer
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::HybridBinarizer
  else
    Class = ZXing::CPP::HybridBinarizer
  end

  def self.new *args
    if self == ZXing::HybridBinarizer
      Class.new(*args)
    else
      super
    end
  end
end
