module ZXing; end
module ZXing::ObjC; end
module ZXing::ObjC:Common; end

class ZXing::ObjC::Common::HybridBinarizer < ZXing::ObjC::Binarizer
  include ZXing::Common::HybridBinarizer
  def initialize luminance_source
    super ::ZXHybridBinarizer.alloc.initWithSource(luminance_source.native), luminance_source
  end
end
