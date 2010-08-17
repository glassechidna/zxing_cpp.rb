module ZXing; end
module ZXing::QRCode; end
module ZXing::QRCode::Encoder; end

module ZXing::QRCode::Encoder::QRCode
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::QRCode::Encoder::QRCode
  else
    Class = ZXing::FFI::QRCode::Encoder::QRCode
  end

  def self.new *args
    if self == ZXing::QRCode::Encoder::QRCode
      Class.new(*args)
    else
      super
    end
  end

  attr_reader :native
  def initialize native
    @native = native
  end
end
