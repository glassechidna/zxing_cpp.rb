module ZXing; end
module ZXing::Java; end

class ZXing::Java::HybridBinarizer < ZXing::Java::Binarizer
  include ZXing::HybridBinarizer
  def initialize luminance_source
    super Java::com::google::zxing::common::HybridBinarizer.new(luminance_source.native), luminance_source
  end
end
