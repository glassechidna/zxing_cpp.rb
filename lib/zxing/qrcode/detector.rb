module ZXing; end
module ZXing::QRCode; end

module ZXing::QRCode::Detector
  include ZXing::Binarizer

  def self.new *args
    if self == ZXing::QRCode::Detector
      ZXing::FFI::QRCode::Detector.new(*args)
    else
      super
    end
  end
end
