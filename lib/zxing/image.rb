module ZXing; end

module ZXing::Image

  def self.read *args
    ZXing::RMagick::Image::read(*args)
  end

  attr_reader :native

  def initialize native
    @native = native
  end

end
