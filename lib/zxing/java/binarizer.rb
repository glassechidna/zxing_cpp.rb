module ZXing; end
module ZXing::Java; end

class ZXing::Java::Binarizer
  include ZXing::Binarizer
  def initialize ptr, source
    super ptr
    @source = source
  end
  attr_reader :source
  def black_matrix
    ZXing::Java::Common::BitMatrix.new native.getBlackMatrix
  end
  def image
    width = source.width
    height = source.height

    image =
      java::awt::image::BufferedImage.new(width,
                                          height,
                                          java::awt::image::BufferedImage::TYPE_BYTE_GRAY)
    matrix = self.black_matrix

    (0...height).each do |y| 
      (0...width).each do |x| 
        image.setRGB x, y, (black_matrix.get(x, y) ? 0 : 0xffffff)
      end
    end

    ZXing::Java::Image.new image
  end
end
