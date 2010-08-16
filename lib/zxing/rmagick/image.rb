require 'RMagick'

module ZXing; end
module ZXing::RMagick; end

class ZXing::RMagick::Image 
  include ZXing::Image
  LuminanceSource = ZXing::FFI::Common::GreyscaleLuminanceSource

  def self.read uri
    img = Magick::Image.read(uri)[0]
    if false
      gs = img.quantize(256, Magick::GRAYColorspace)
      (0..0).each do |j|
        (0..25).each do |i|
          p i,j
          pixel = img.pixel_color(i,j)
          r = pixel.red&0xff
          g = pixel.green&0xff
          b = pixel.blue&0xff
          puts '%x'%r, '%x'%g, '%x'%b
          pixel = gs.pixel_color(i,j)
          puts(pixel.red&0xff)
          puts((306 * (r) + 601 * (g) + 117 * (b)) >> 10)
          puts
        end
      end
    end
    self.new img
  end

  def rotate angle
    self.class.new @native.rotate(angle)
  end

  def width
    @native.columns
  end

  def height
    @native.rows
  end

  def gray
    @native.export_pixels_to_str(0, 0, @native.columns, @native.rows, "I")
  end

end
