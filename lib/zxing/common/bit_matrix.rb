module ZXing; end

module ZXing::BitMatrix
  attr_reader :native
  def initialize native
    @native = native
  end
end
