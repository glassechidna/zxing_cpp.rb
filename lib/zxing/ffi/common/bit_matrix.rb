module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::BitMatrix
  include ZXing::BitMatrix
  def initialize ptr
    super ZXing::FFI::FFI::BitMatrixPointer.new ptr
  end
  def get x, y
    ZXing::FFI::FFI.BitMatrix_get native, x, y
  end
end
