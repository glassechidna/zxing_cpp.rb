module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::DataMatrixReader < ZXing::FFI::Reader
  include ZXing::DataMatrixReader
  def initialize
    super ZXing::FFI::FFI.DataMatrixReader_new
  end
end
