module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::Common::BitMatrix
  include ZXing::Common::BitMatrix
  def initialize ptr
    super ZXing::FFI::Library::BitMatrixPointer.new ptr
  end
  def get x, y
    ZXing::FFI::Library.BitMatrix_get native, x, y
  end
end
