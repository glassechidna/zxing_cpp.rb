module ZXing; end
module ZXing::ObjC; end

class ZXing::ObjC::BinaryBitmap
  include ZXing::BinaryBitmap
  def initialize binarizer
    super ::ZXBinaryBitmap.alloc.initWithBinarizer(binarizer.native)
  end
  def black_matrix
    ZXing::ObjC::Common::BitMatrix.new native
  end
end
