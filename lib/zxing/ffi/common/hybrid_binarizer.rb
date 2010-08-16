module ZXing; end
module ZXing::FFI; end
module ZXing::FFI:Common; end

class ZXing::FFI::Common::HybridBinarizer < ZXing::FFI::Binarizer
  include ZXing::Common::HybridBinarizer
  def initialize luminance_source
    super ZXing::FFI::Library.HybridBinarizer_new(luminance_source.native), luminance_source
  end
end
