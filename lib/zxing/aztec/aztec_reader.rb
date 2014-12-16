module ZXing; end

module ZXing::Aztec::AztecReader
  extend ZXing::Reader

  def self.new *args
    if self == ZXing::Aztec::AztecReader
      ZXing::FFI::Aztec::AztecReader.new
    else
      super
    end
  end

end
