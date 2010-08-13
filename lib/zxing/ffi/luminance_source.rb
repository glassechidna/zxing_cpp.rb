module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::LuminanceSource
  include ZXing::LuminanceSource
  def initialize ptr
    super ZXing::CPP::FFI::LuminanceSourcePointer.new ptr
  end
  def width
    ZXing::CPP::FFI.LuminanceSource_width native
  end
  def height
    ZXing::CPP::FFI.LuminanceSource_height native
  end
  def matrix
    ZXing::CPP::FFI.LuminanceSource_matrix native
  end
end
