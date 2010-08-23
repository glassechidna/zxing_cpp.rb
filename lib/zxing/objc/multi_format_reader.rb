module ZXing; end
module ZXing::ObjC; end

class ZXing::ObjC::MultiFormatReader < ZXing::ObjC::Reader
  include ZXing::MultiFormatReader
  def initialize
    super ::ZXMultiFormatReader.alloc.init
  end
end
