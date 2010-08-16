module ZXing; end

module ZXing::Result
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Result
  else
    Class = ZXing::FFI::Result
  end

  def self.new *args
    if self == ZXing::Result
      Class.new(*args)
    else
      super
    end
  end

  attr_reader :native

  def initialize native
    @native = native
  end

end
