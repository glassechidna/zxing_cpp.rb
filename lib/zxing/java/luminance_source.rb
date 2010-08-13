module ZXing; end
module ZXing::Java; end

class ZXing::Java::LuminanceSource
  include ZXing::LuminanceSource
  def width
    native.getWidth
  end
  def height
    native.getHeight
  end
  def matrix
    native.getMatrix
  end
end
