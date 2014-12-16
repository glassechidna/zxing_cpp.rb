module ZXing; end

module ZXing::BinaryBitmap
  def self.new *args
    if self == ZXing::BinaryBitmap
      ZXing::FFI::BinaryBitmap.new(*args)
    end
  end

  attr_reader :native

  def initialize native
    @native = native
  end
end
