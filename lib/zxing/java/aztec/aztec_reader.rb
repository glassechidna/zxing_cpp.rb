module ZXing; end
module ZXing::Java; end
module ZXing::Java::Aztec; end

class ZXing::Java::Aztec::AztecReader < ZXing::Java::Reader
  include ZXing::Aztec::AztecReader
  def initialize
    super Java::com::google::zxing::aztec::AztecReader.new
  end
end
