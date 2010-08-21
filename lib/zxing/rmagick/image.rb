require 'RMagick'

module ZXing; end
module ZXing::RMagick; end

class ZXing::RMagick::Image 
  include ZXing::Image
  LuminanceSource = ZXing::FFI::Common::GreyscaleLuminanceSource

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
 
    img = nil

    begin
      img = case uri.scheme
            when "file"; Magick::Image.read(uri.path)[0]
            else; Magick::Image.from_blob(fetch(uri).body)[0]
            end
    rescue Exception => e
      raise ZXing::BadImageException.new e.message
    end

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

  private

  def self.fetch(uri, limit = 10)
    # You should choose better exception.
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    require 'net/http'

    response = Net::HTTP.get_response(uri)
    case response
    when Net::HTTPSuccess; response
    when Net::HTTPRedirection
      fetch(URI.parse(response['location']), limit-1)
    else
      response.error!
    end
  end
end
