module ZXing; end

module ZXing::DataMatrixReader
  extend ZXing::Reader

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::DataMatrixReader
  else
    Class = ZXing::CPP::DataMatrixReader
  end

  def self.new *args
    if self == ZXing::DataMatrixReader
      Class.new
    else
      super
    end
  end

end
