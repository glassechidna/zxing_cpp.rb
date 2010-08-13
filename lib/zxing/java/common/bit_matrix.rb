module ZXing; end
module ZXing::Java; end

class ZXing::Java::BitMatrix
  include ZXing::BitMatrix
  def get x, y
    native.get x, y
  end
end
