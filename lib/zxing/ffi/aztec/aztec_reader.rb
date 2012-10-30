module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::Aztec::AztecReader < ZXing::FFI::Reader
  include ZXing::Aztec::AztecReader
  def initialize
    super ZXing::FFI::Library.AztecReader_new
  end
end
