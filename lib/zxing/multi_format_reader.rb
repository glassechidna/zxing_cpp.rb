module ZXing; end

module ZXing::MultiFormatReader
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::MultiFormatReader
  else
    if defined? RUBY_ENGINE and RUBY_ENGINE == "macruby"
      Class = ZXing::ObjC::MultiFormatReader
    else
      Class = ZXing::FFI::MultiFormatReader
    end
  end

  def self.new *args
    if self == ZXing::MultiFormatReader
      Class.new
    else
      super
    end
  end
end
