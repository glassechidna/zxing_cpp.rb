module ZXing; end
module ZXing::QRCode; end
module ZXing::QRCode::Encoder; end

module ZXing::QRCode::Encoder::ByteMatrix
  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::QRCode::Encoder::ByteMatrix
  else
    Class = ZXing::FFI::QRCode::Encoder::ByteMatrix
  end

  def self.new *args
    if self == ZXing::QRCode::Encoder::ByteMatrix
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
