module ZXing; end
module ZXing::Java; end

class ZXing::Java::Image
  include ZXing::Image

  LuminanceSource =
    ZXing::Java::Client::J2SE::BufferedImageLuminanceSource

  def self.read uri
    if !(String === uri)
      begin uri = uri.path; rescue; end
    end

    if !(String === uri)
      begin uri = uri.to_s; rescue; end
    end

    require 'uri'
    require 'pathname'

    uri = URI.parse uri
    if uri.scheme.nil?
      uri.scheme = "file"
      uri.path = Pathname.new(uri.path).realpath.to_s
    end
    uri = case uri.scheme
    when "file"; uri.to_s.sub(%r{:/}, ":///")
    else; uri.to_s
    end

    file = java::net::URL.new uri
    img = javax::imageio::ImageIO.read file
    if img.nil?
      raise ZXing::BadImageException.new("could not interpret #{uri} as an image")
    end
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
      original = native

      case original.getType
      when java::awt::image::BufferedImage::TYPE_BYTE_INDEXED, java::awt::image::BufferedImage::TYPE_BYTE_BINARY
        argb = java::awt::image::BufferedImage.new(original.getWidth,
                                                    original.getHeight,
                                                    java::awt::image::BufferedImage::TYPE_INT_ARGB)
        g = argb.createGraphics
        g.drawImage original, 0, 0, nil
        g.dispose
        original = argb
      else;
      end

      radians = java::lang::Math.toRadians degrees

      # Transform simply to find out the new bounding box (don't actually run the image through it)
      at = java::awt::geom::AffineTransform.new
      at.rotate radians, original.getWidth/2.0, original.getHeight/2.0
      op =
        java::awt::image::AffineTransformOp.new at, java::awt::image::AffineTransformOp::TYPE_BICUBIC
        
      r = op.getBounds2D original
      width = r.width.ceil
      height = r.height.ceil

      # Real transform, now that we know the size of the new image and how to translate after we rotate
      # to keep it centered
      at = java::awt::geom::AffineTransform.new
      at.rotate radians, width/2.0, height/2.0
      at.translate((width-original.getWidth)/2.0, (height-original.getHeight)/2.0)

      op =
        java::awt::image::AffineTransformOp.new at, java::awt::image::AffineTransformOp::TYPE_BICUBIC

      rotated = op.filter(original, java::awt::image::BufferedImage.new(width,
                                                                        height,
                                                                        original.getType))
      self.class.new rotated
    end
  end
end
