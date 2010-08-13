module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::HybridBinarizer < ZXing::CPP::Binarizer
  include ZXing::HybridBinarizer
  def initialize luminance_source
    super ZXing::CPP::FFI.HybridBinarizer_new(luminance_source.native), luminance_source
  end
end
