module ZXing; end
module ZXing::Java; end
module ZXing::Java::Client; end
module ZXing::Java::Client::J2SE; end

require 'zxing/javase.jar'

class ZXing::Java::Client::J2SE::BufferedImageLuminanceSource <
    ZXing::Java::LuminanceSource

  def initialize image, left = nil, top = nil, width = nil, height = nil
    left == nil && left = 0
    top == nil && top = 0
    width == nil && width = image.width
    height == nil && height = image.height
    super Java::com::google::zxing::client::j2se::
      BufferedImageLuminanceSource.new(image.native, left, top, width, height)
  end
  def image
    image = java::awt::image::BufferedImage.new width, height, java::awt::image::BufferedImage::TYPE_BYTE_GRAY
    matrix = self.matrix
    (0...height).each do |y| 
      (0...width).each do |x| 
        image.setRGB x, y, matrix[y*width + x]
      end
    end
    ZXing::Java::Image.new image
  end
end
