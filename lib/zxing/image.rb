module ZXing; end

module ZXing::Image

  if RUBY_PLATFORM == "java"
    Class = ZXing::Java::Image
  else
    Class = ZXing::RMagick::Image
  end

  def self.read *args
    Class::read(*args)
  end

  attr_reader :native

  def initialize native
    @native = native
  end

end
