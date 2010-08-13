module ZXing; end

include Java
require 'zxing/core.jar'

module ZXing::Java
  autoload :Reader, 'zxing/java/reader'
  autoload :LuminanceSource, 'zxing/java/luminance_source'
  autoload :BufferedImageLuminanceSource, 'zxing/java/buffered_image_luminance_source'
  autoload :Binarizer, 'zxing/java/binarizer'
  autoload :HybridBinarizer, 'zxing/java/hybrid_binarizer'
  autoload :BinaryBitmap, 'zxing/java/binary_bitmap'
  autoload :MultiFormatReader, 'zxing/java/multi_format_reader'
  autoload :DataMatrixReader, 'zxing/java/data_matrix_reader'
  autoload :Code39Reader, 'zxing/java/code_39_reader'
  autoload :Result, 'zxing/java/result'
  autoload :BitMatrix, 'zxing/java/bit_matrix'
  autoload :Image, 'zxing/java/image'
end
