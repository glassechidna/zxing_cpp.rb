module ZXing; end
module ZXing::QRCode; end

module ZXing::QRCode::Decoder
  include ZXing::Binarizer

  def self.new *args
    if self == ZXing::QRCode::Decoder
      ZXing::FFI::QRCode::Decoder.new(*args)
    else
      super
    end
  end
end
