module ZXing; end
module ZXing::Java; end
module ZXing::Java::QRCode; end

module ZXing::Java::QRCode::Encoder
  autoload :Encoder, 'zxing/java/qrcode/encoder/encoder'
  autoload :QRCode, 'zxing/java/qrcode/encoder/qrcode'
  autoload :ByteMatrix, 'zxing/java/qrcode/encoder/byte_matrix'
end
