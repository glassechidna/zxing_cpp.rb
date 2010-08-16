module ZXing; end
module ZXing::Java; end
module ZXing::Java::OneD; end

class ZXing::Java::OneD::Code39Reader < ZXing::Java::Reader
  include ZXing::OneD::Code39Reader
  def initialize usingCheckDigit, extendedMode
    super Java::com::google::zxing::oned::Code39Reader.new(usingCheckDigit, extendedMode)
  end
end
