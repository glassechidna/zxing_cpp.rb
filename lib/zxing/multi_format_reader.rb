module ZXing; end

module ZXing::MultiFormatReader
  def self.new *args
    if self == ZXing::MultiFormatReader
      ZXing::FFI::MultiFormatReader.new
    else
      super
    end
  end
end
