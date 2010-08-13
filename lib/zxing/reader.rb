module ZXing; end

module ZXing::Reader
  attr_reader :native
  def initialize native
    @native = native
  end
end
