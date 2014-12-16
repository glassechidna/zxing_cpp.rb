module ZXing; end

module ZXing::Result
  def self.new *args
    if self == ZXing::Result
      ZXing::FFI::Result.new(*args)
    else
      super
    end
  end

  attr_reader :native

  def initialize native
    @native = native
  end

end
