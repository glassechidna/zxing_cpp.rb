module ZXing; end
module ZXing::OneD; end

module ZXing::OneD::Code39Reader
  extend ZXing::Reader

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::OneD::Code39Reader
  else
    Class = ZXing::FFI::OneD::Code39Reader
  end

  def self.new *args
    if self == ZXing::OneD::Code39Reader
      Class.new(*args)
    else
      super
    end
  end

end
