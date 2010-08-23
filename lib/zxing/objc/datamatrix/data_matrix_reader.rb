module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::DataMatrix::DataMatrixReader < ZXing::FFI::Reader
  include ZXing::DataMatrix::DataMatrixReader
  def initialize
    super ZXing::FFI::Library.DataMatrixReader_new
  end
end
