module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::MultiFormatReader < ZXing::FFI::Reader
  include ZXing::MultiFormatReader
  def initialize
    super ZXing::FFI::Library.MultiFormatReader_new
  end
end
