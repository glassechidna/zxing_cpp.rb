module ZXing; end
module ZXing::QRCode; end
module ZXing::QRCode::Encoder; end

module ZXing::QRCode::Encoder::Encoder
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::QRCode::Encoder::Encoder
  else
    Class = ZXing::FFI::QRCode::Encoder::Encoder
  end

  def self.encode *args
    Class.encode *args
  end
end
