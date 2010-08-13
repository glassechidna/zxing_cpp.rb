module ZXing; end

module ZXing::CPP
  autoload :Reader, 'zxing/cpp/reader'
  autoload :LuminanceSource, 'zxing/cpp/luminance_source'
  autoload :GreyscaleLuminanceSource, 'zxing/cpp/greyscale_luminance_source'
  autoload :Binarizer, 'zxing/cpp/binarizer'
  autoload :HybridBinarizer, 'zxing/cpp/hybrid_binarizer'
  autoload :BinaryBitmap, 'zxing/cpp/binary_bitmap'
  autoload :MultiFormatReader, 'zxing/cpp/multi_format_reader'
  autoload :DataMatrixReader, 'zxing/cpp/data_matrix_reader'
  autoload :Code39Reader, 'zxing/cpp/code_39_reader'
  autoload :FFI, 'zxing/cpp/ffi'
  autoload :Result, 'zxing/cpp/result'
  autoload :BitMatrix, 'zxing/cpp/bit_matrix'
end
