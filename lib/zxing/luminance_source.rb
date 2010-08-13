module ZXing; end

module ZXing::LuminanceSource

  def self.new image
    if self == ZXing::LuminanceSource
      image.class.const_get("LuminanceSource").new image
    else
      super
    end
  end

  attr_reader :native

  def initialize native
    @native = native
  end
end
