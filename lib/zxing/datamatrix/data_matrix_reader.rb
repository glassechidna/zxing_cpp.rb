module ZXing; end

module ZXing::DataMatrix::DataMatrixReader
  extend ZXing::Reader

  def self.new *args
    if self == ZXing::DataMatrix::DataMatrixReader
      ZXing::FFI::DataMatrix::DataMatrixReader.new
    else
      super
    end
  end

end
