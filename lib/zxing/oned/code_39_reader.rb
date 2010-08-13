module ZXing; end

module ZXing::Code39Reader
  extend ZXing::Reader

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Code39Reader
  else
    Class = ZXing::CPP::Code39Reader
  end

  def self.new *args
    if self == ZXing::Code39Reader
      Class.new(*args)
    else
      super
    end
  end

end
