module ZXing; end
module ZXing::Java; end
module ZXing::Java::Common; end

class ZXing::Java::Common::HybridBinarizer < ZXing::Java::Binarizer
  include ZXing::Common::HybridBinarizer
  def initialize luminance_source
    super Java::com::google::zxing::common::HybridBinarizer.new(luminance_source.native), luminance_source
  end
end
