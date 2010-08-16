module ZXing; end
module ZXing::FFI; end
module ZXing::FFI::OneD; end

class ZXing::FFI::OneD::Code39Reader < ZXing::FFI::Reader
  include ZXing::OneD::Code39Reader
  def initialize usingCheckDigit, extendedMode
    super ZXing::FFI::Library.Code39Reader_new usingCheckDigit, extendedMode
  end
end
