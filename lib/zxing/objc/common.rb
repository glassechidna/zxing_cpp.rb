module ZXing; end
module ZXing::ObjC; end

module ZXing::ObjC::Common
  autoload :CGImageLuminanceSource, 'zxing/objc/common/cgimage_luminance_source'
  autoload :BitMatrix, 'zxing/objc/common/bit_matrix'
  autoload :HybridBinarizer, 'zxing/objc/common/hybrid_binarizer'
end
