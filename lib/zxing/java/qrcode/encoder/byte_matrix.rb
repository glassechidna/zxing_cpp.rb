module ZXing; end
module ZXing::Java; end
module ZXing::Java::QRCode; end
module ZXing::Java::QRCode::Encoder; end

class ZXing::Java::QRCode::Encoder::ByteMatrix
  include ZXing::QRCode::Encoder::ByteMatrix
  
  def image
    width = native.width
    height = native.height

    image =
      java::awt::image::BufferedImage.new(width,
                                          height,
                                          java::awt::image::BufferedImage::TYPE_BYTE_GRAY)
    (0...height).each do |y| 
      (0...width).each do |x| 
        image.setRGB x, y, (native.get(x, y) == 1 ? 0 : 0xffffff)
      end
    end

    ZXing::Java::Image.new image
  end

end
