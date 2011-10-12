module ZXing; end

include Java
require 'zxing/core.jar'

module ZXing::Java
  autoload :Reader, 'zxing/java/reader'
  autoload :MultiFormatReader, 'zxing/java/multi_format_reader'
  autoload :Result, 'zxing/java/result'
  autoload :LuminanceSource, 'zxing/java/luminance_source'
  autoload :Binarizer, 'zxing/java/binarizer'
  autoload :BinaryBitmap, 'zxing/java/binary_bitmap'

  autoload :Image, 'zxing/java/image'

  autoload :Common, 'zxing/java/common'
  autoload :OneD, 'zxing/java/oned'
  autoload :DataMatrix, 'zxing/java/datamatrix'
  autoload :Aztec, 'zxing/java/aztec'
  autoload :Client, 'zxing/java/client'
  autoload :QRCode, 'zxing/java/qrcode'
end
