module ZXing; end
module ZXing::Java; end

class ZXing::Java::MultiFormatReader < ZXing::Java::Reader
  include ZXing::MultiFormatReader
  def initialize
    super Java::com::google::zxing::MultiFormatReader.new
  end
end
