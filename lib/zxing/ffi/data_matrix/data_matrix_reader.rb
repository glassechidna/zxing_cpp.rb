module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::DataMatrixReader < ZXing::CPP::Reader
  include ZXing::DataMatrixReader
  def initialize
    super ZXing::CPP::FFI.DataMatrixReader_new
  end
end
