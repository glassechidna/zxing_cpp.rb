module ZXing; end
module ZXing::QRCode; end

module ZXing::QRCode::Encoder
  autoload :Encoder, 'zxing/qrcode/encoder/encoder'
  autoload :QRCode, 'zxing/qrcode/encoder/qrcode'
  autoload :ByteMatrix, 'zxing/qrcode/encoder/byte_matrix'
end
