module ZXing; end

framework 'AppKit'
require 'zxing/objc/zxing'

module ZXing::ObjC
  autoload :Reader, 'zxing/objc/reader'
  autoload :MultiFormatReader, 'zxing/objc/multi_format_reader'
  autoload :Result, 'zxing/objc/result'
  autoload :LuminanceSource, 'zxing/objc/luminance_source'
  autoload :Binarizer, 'zxing/objc/binarizer'
  autoload :BinaryBitmap, 'zxing/objc/binary_bitmap'

  autoload :Image, 'zxing/objc/image'

  autoload :Common, 'zxing/objc/common'
  autoload :OneD, 'zxing/objc/oned'
  autoload :DataMatrix, 'zxing/objc/datamatrix'
  autoload :Client, 'zxing/objc/client'
  autoload :QRCode, 'zxing/objc/qrcode'
end
