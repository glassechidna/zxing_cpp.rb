module ZXing; end
module ZXing::Java; end
module ZXing::Java::Common; end

class ZXing::Java::Common::BitMatrix
  include ZXing::Common::BitMatrix
  def get x, y
    native.get x, y
  end
end
