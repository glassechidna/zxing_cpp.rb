module ZXing; end

module ZXing::Binarizer
  attr_reader :native
  def initialize native
    @native = native
  end
end
