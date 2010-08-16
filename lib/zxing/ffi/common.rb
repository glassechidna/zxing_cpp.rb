module ZXing; end
module ZXing::FFI; end

module ZXing::FFI::Common
  autoload :GreyscaleLuminanceSource, 'zxing/ffi/common/greyscale_luminance_source'
  autoload :BitMatrix, 'zxing/ffi/common/bit_matrix'
  autoload :HybridBinarizer, 'zxing/ffi/common/hybrid_binarizer'
end
