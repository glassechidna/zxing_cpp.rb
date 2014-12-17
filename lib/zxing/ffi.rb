module ZXing; end

require 'ffi'

module ZXing::FFI
  autoload :Library, 'zxing/ffi/library'

  autoload :Reader, 'zxing/ffi/reader'
  autoload :MultiFormatReader, 'zxing/ffi/multi_format_reader'
  autoload :Result, 'zxing/ffi/result'
  autoload :LuminanceSource, 'zxing/ffi/luminance_source'
  autoload :Binarizer, 'zxing/ffi/binarizer'
  autoload :BinaryBitmap, 'zxing/ffi/binary_bitmap'

  autoload :Common, 'zxing/ffi/common'
  autoload :OneD, 'zxing/ffi/oned'
  autoload :DataMatrix, 'zxing/ffi/datamatrix'
  autoload :Aztec, 'zxing/ffi/aztec'
  autoload :QRCode, 'zxing/ffi/qrcode'
end
