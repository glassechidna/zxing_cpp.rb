module ZXing; end
module ZXing::Common; end

module ZXing::Common::BitMatrix
  attr_reader :native
  def initialize native
    @native = native
  end
end
