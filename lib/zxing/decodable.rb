require 'zxing'

module Decodable
  def decode
    ZXing.decode(self)
  end

  def decode!
    ZXing.decode!(self)
  end
end
