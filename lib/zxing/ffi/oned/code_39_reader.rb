module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::Code39Reader < ZXing::CPP::Reader
  include ZXing::Code39Reader
  def initialize usingCheckDigit, extendedMode
    super ZXing::CPP::FFI.Code39Reader_new usingCheckDigit, extendedMode
  end
end
