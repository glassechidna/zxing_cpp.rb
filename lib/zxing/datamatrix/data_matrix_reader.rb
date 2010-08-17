module ZXing; end

module ZXing::DataMatrix::DataMatrixReader
  extend ZXing::Reader

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::DataMatrix::DataMatrixReader
  else
    Class = ZXing::FFI::DataMatrix::DataMatrixReader
  end

  def self.new *args
    if self == ZXing::DataMatrix::DataMatrixReader
      Class.new
    else
      super
    end
  end

end
