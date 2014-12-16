module ZXing; end
module ZXing::QRCode; end
module ZXing::QRCode::Encoder; end

module ZXing::QRCode::Encoder::QRCode
  def self.new *args
    if self == ZXing::QRCode::Encoder::QRCode
      ZXing::FFI::QRCode::Encoder::QRCode.new(*args)
    else
      super
    end
  end

  attr_reader :native
  def initialize native
    @native = native
  end
end
