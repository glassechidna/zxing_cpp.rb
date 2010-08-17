module ZXing; end
module ZXing::Java; end
module ZXing::Java::DataMatrix; end

class ZXing::Java::DataMatrix::DataMatrixReader < ZXing::Java::Reader
  include ZXing::DataMatrix::DataMatrixReader
  def initialize
    super Java::com::google::zxing::datamatrix::DataMatrixReader.new
  end
end
