module ZXing; end
module ZXing::ObjC; end

class ZXing::ObjC::LuminanceSource
  include ZXing::LuminanceSource
  def width
    native.width
  end
  def height
    native.height
  end
  def matrix
    native.matrix
  end
end
