module ZXing; end
module ZXing::QRCode; end

module ZXing::QRCode::Detector
  include ZXing::Binarizer
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::QRCode::Detector
  else
    Class = ZXing::FFI::QRCode::Detector
  end

  def self.new *args
    if self == ZXing::QRCode::Detector
      Class.new(*args)
    else
      super
    end
  end
end
