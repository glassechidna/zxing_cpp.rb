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
  autoload :DataMatrix, 'zxing/java/data_matrix'
  autoload :Client, 'zxing/java/client'

  # autoload :DataMatrixReader, 'zxing/java/data_matrix_reader'
  # autoload :HybridBinarizer, 'zxing/java/hybrid_binarizer'
  # autoload :BufferedImageLuminanceSource, 'zxing/java/buffered_image_luminance_source'
  # autoload :BitMatrix, 'zxing/java/bit_matrix'
  # autoload :Code39Reader, 'zxing/java/code_39_reader'

end
