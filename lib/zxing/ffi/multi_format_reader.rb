module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::MultiFormatReader < ZXing::CPP::Reader
  include ZXing::MultiFormatReader
  def initialize
    super ZXing::CPP::FFI.MultiFormatReader_new
  end
end
