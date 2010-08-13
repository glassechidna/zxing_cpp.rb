module ZXing; end
module ZXing::Java; end

class ZXing::Java::DataMatrixReader < ZXing::Java::Reader
  include ZXing::DataMatrixReader
  def initialize
    super Java::com::google::zxing::DataMatrixReader.new
  end
end
