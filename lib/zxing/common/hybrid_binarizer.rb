module ZXing; end
module ZXing::Common; end

module ZXing::Common::HybridBinarizer
  def self.new *args
    if self == ZXing::Common::HybridBinarizer
      ZXing::FFI::Common::HybridBinarizer.new(*args)
    else
      super
    end
  end

  def initialize *args
    super *args
  end

end
