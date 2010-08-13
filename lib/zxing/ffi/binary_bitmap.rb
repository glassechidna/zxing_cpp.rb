module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::BinaryBitmap
  include ZXing::BinaryBitmap
  def initialize binarizer
    super ZXing::CPP::FFI::BinaryBitmapPointer.new ZXing::CPP::FFI.BinaryBitmap_new(binarizer.native)
  end
  def count
    ZXing::CPP::FFI.BinaryBitmap_count @native
  end
end
