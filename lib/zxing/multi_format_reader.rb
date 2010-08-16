module ZXing; end

module ZXing::MultiFormatReader
  extend ZXing::Reader

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::MultiFormatReader
  else
    Class = ZXing::FFI::MultiFormatReader
  end

  def self.new *args
    if self == ZXing::MultiFormatReader
      Class.new
    else
      super
    end
  end

end
