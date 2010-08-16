module ZXing
  autoload :Common, 'zxing/common'

  autoload :Java, 'zxing/java'
  autoload :FFI, 'zxing/ffi'
  autoload :RMagick, 'zxing/rmagick'

  autoload :Image, 'zxing/image'

  autoload :Reader, 'zxing/reader'
  autoload :MultiFormatReader, 'zxing/multi_format_reader'
  autoload :Result, 'zxing/result'
  autoload :LuminanceSource, 'zxing/luminance_source'
  autoload :BinaryBitmap, 'zxing/binary_bitmap'
  autoload :Binarizer, 'zxing/binarizer'

  autoload :NotFoundException, 'zxing/not_found_exception'
  autoload :ReaderException, 'zxing/reader_exception'
  autoload :IllegalArgumentException, 'zxing/illegal_argument_exception'
  autoload :ChecksumException, 'zxing/checksum_exception'
  autoload :FormatException, 'zxing/format_exception'

  autoload :DataMatrix, 'zxing/data_matrix'
  autoload :OneD, 'zxing/oned'
  autoload :Common, 'zxing/common'
  autoload :PDF417, 'zxing/pdf417'
  autoload :QRCode, 'zxing/qrcode'
end
