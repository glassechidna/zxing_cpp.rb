module ZXing; end
module ZXing::QRCode; end

module ZXing::QRCode::Decoder
  include ZXing::Binarizer
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::QRCode::Decoder
  else
    Class = ZXing::FFI::QRCode::Decoder
  end

  def self.new *args
    if self == ZXing::QRCode::Decoder
      Class.new(*args)
    else
      super
    end
  end
end
