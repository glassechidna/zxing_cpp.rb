module ZXing; end
module ZXing::OneD; end

module ZXing::OneD::Code39Reader
  extend ZXing::Reader

  def self.new *args
    if self == ZXing::OneD::Code39Reader
      ZXing::FFI::OneD::Code39Reader.new(*args)
    else
      super
    end
  end

end
