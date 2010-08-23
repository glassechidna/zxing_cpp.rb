module ZXing; end
module ZXing::FFI; end

module ZXing::FFI::QRCode
  autoload :Detector, 'zxing/ffi/qrcode/detector'
  autoload :Decoder, 'zxing/ffi/qrcode/decoder'
  autoload :QRCodeReader, 'zxing/ffi/qrcode/qrcode_reader'
end
