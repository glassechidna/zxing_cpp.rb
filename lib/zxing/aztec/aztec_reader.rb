module ZXing; end

module ZXing::Aztec::AztecReader
  extend ZXing::Reader

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Aztec::AztecReader
  else
    Class = ZXing::FFI::Aztec::AztecReader
  end

  def self.new *args
    if self == ZXing::Aztec::AztecReader
      Class.new
    else
      super
    end
  end

end
