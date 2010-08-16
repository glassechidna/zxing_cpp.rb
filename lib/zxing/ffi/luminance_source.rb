module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::LuminanceSource
  include ZXing::LuminanceSource
  def initialize ptr
    super ZXing::FFI::Library::LuminanceSourcePointer.new ptr
  end
  def width
    ZXing::FFI::Library.LuminanceSource_width native
  end
  def height
    ZXing::FFI::Library.LuminanceSource_height native
  end
  def matrix
    ZXing::FFI::Library.LuminanceSource_matrix native
  end
end
