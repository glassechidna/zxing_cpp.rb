module ZXing; end
module ZXing::QRCode; end
module ZXing::QRCode::Encoder; end

module ZXing::QRCode::Encoder::ByteMatrix
  def self.new *args
    if self == ZXing::QRCode::Encoder::ByteMatrix
      ZXing::FFI::QRCode::Encoder::ByteMatrix.new(*args)
    else
      super
    end
  end

  attr_reader :native
  def initialize native
    @native = native
  end
end
