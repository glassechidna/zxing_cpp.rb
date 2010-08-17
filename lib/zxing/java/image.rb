module ZXing; end
module ZXing::Java; end

class ZXing::Java::Image
  include ZXing::Image

  LuminanceSource =
    ZXing::Java::Client::J2SE::BufferedImageLuminanceSource

  def self.read uri
    file = java::io::File.new uri
    img = javax::imageio::ImageIO.read file
    self.new img
  end

  def write file
    case file
    when String; file = java::io::File.new file
    when STDOUT; file = java::system::out
    when STDERR; file = java::system::err
    else; raise "don't know how to map file #{file}"
    end
    javax::imageio::ImageIO.write native, "png", file
  end

  def rotate angle
    self.class.new @native.rotate(angle)
  end

  def width
    @native.getWidth
  end

  def height
    @native.getHeight
  end

  def rotate degrees
    if degrees == 0
      self
    else
      radians = java::lang::Math.toRadians degrees

      # Transform simply to find out the new bounding box (don't actually run the image through it)
      at = java::awt::geom::AffineTransform.new
      at.rotate radians, self.width/2.0, self.height/2.0
      op =
        java::awt::image::AffineTransformOp.new at, java::awt::image::AffineTransformOp::TYPE_BICUBIC
        
      r = op.getBounds2D native
      width = r.width.ceil
      height = r.height.ceil

      # Real transform, now that we know the size of the new image and how to translate after we rotate
      # to keep it centered
      at = java::awt::geom::AffineTransform.new
      at.rotate radians, width/2.0, height/2.0
      at.translate((width-self.width)/2.0, (height-self.height)/2.0)
      op =
        java::awt::image::AffineTransformOp.new at, java::awt::image::AffineTransformOp::TYPE_BICUBIC

      self.class.new op.filter native, nil
    end
  end
end
