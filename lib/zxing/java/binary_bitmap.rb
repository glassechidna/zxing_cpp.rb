module ZXing; end
module ZXing::Java; end

class ZXing::Java::BinaryBitmap
  include ZXing::BinaryBitmap
  def initialize binarizer
    super Java::com::google::zxing::BinaryBitmap.new(binarizer.native)
  end
  def count
    native.count
  end
end
