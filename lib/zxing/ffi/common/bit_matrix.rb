module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::BitMatrix
  include ZXing::BitMatrix
  def initialize ptr
    super ZXing::CPP::FFI::BitMatrixPointer.new ptr
  end
  def get x, y
    ZXing::CPP::FFI.BitMatrix_get native, x, y
  end
end
