module ZXing; end

module ZXing::Binarizer
  attr_reader :native
  def initialize native, *args
    @native = native
  end
end
