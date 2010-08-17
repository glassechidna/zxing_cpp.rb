module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::BinaryBitmap
  include ZXing::BinaryBitmap
  def initialize binarizer
    super ZXing::FFI::Library::BinaryBitmapPointer.new ZXing::FFI::Library.BinaryBitmap_new(binarizer.native)
  end
  def count
    ZXing::FFI::Library.BinaryBitmap_count @native
  end
  def black_matrix
    ZXing::FFI::Common::BitMatrix.new ZXing::FFI::Library.BinaryBitmap_black_matrix(native)
  end
end
