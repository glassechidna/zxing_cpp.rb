module ZXing; end

module ZXing::QRCode
  autoload :QRCodeReader, 'zxing/qrcode/qrcode_reader'
  autoload :Detector, 'zxing/qrcode/detector'
  autoload :Decoder, 'zxing/qrcode/decoder'
  autoload :Encoder, 'zxing/qrcode/encoder'
end
