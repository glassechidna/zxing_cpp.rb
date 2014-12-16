module ZXing; end
module ZXing::QRCode; end
module ZXing::QRCode::Encoder; end

module ZXing::QRCode::Encoder::Encoder
  def self.encode *args
    ZXing::FFI::QRCode::Encoder::Encoder.encode *args
  end
end
