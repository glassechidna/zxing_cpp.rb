module ZXing; end
module ZXing::Java; end
module ZXing::Java::QRCode; end
module ZXing::Java::QRCode::Encoder; end

class ZXing::Java::QRCode::Encoder::QRCode
  include ZXing::QRCode::Encoder::QRCode
  def initialize *args
    super Java::com::google::zxing::qrcode::encoder::QRCode.new *args
  end
  def matrix
    ZXing::QRCode::Encoder::ByteMatrix.new native.getMatrix
  end
end
