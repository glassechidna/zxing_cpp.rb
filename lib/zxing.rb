module ZXing
  autoload :Java, 'zxing/java'
  autoload :CPP, 'zxing/cpp'
  autoload :RMagick, 'zxing/rmagick'

  autoload :Image, 'zxing/image'

  autoload :LuminanceSource, 'zxing/luminance_source'
  autoload :BinaryBitmap, 'zxing/binary_bitmap'
  autoload :Binarizer, 'zxing/binarizer'
  autoload :HybridBinarizer, 'zxing/hybrid_binarizer'
  autoload :NotFoundException, 'zxing/not_found_exception'
  autoload :ReaderException, 'zxing/reader_exception'
  autoload :IllegalArgumentException, 'zxing/illegal_argument_exception'
  autoload :Reader, 'zxing/reader'
  autoload :MultiFormatReader, 'zxing/multi_format_reader'
  autoload :Result, 'zxing/result'
  autoload :BitMatrix, 'zxing/bit_matrix'

  autoload :DataMatrix, 'zxing/data_matrix'
  autoload :OneD, 'zxing/oned'
  autoload :Common, 'zxing/common'
  autoload :PDF417, 'zxing/pdf417'
  autoload :QRCode, 'zxing/qrcode'
end
