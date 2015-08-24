begin
  # Support both newer 'rmagick' require and deprecated 'RMagick' require:
  require 'rmagick'
rescue LoadError => e
  require 'RMagick'
end

module ZXing; end
module ZXing::RMagick; end

class ZXing::RMagick::Image
  include ZXing::Image
  LuminanceSource = ZXing::FFI::Common::GreyscaleLuminanceSource

  def self.read argument
    img = nil

    if argument.is_a? String
      if argument.encoding.name == Encoding.aliases['BINARY']
        begin
          img = Magick::Image.from_blob(argument)[0]
        rescue Exception => e
          # Because 'BINARY' is just an alias for ASCII-8BIT, if treating the
          # argument as image blob failed, we should continue on and try treat
          # the argument like a regular string.
        end
      end
    end

    if img.nil?
      require 'uri'
      require 'pathname'

      uri = URI.parse(argument.respond_to?(:path) ? argument.path : argument.to_s)

      if uri.scheme.nil?
        uri.scheme = "file"
        uri.path = Pathname.new(uri.path).realpath.to_s
      end

      begin
        img = case uri.scheme
                when "file"; Magick::Image.read(uri.path)[0]
                else; Magick::Image.from_blob(fetch(uri).body)[0]
              end
      rescue Exception => e
        raise ZXing::BadImageException.new e.message
      end
    end

    # p Magick::Magick_version
    # p img.colorspace
    img.colorspace = Magick::RGBColorspace
    # p img.colorspace

    if false
      (8..8).each do |j|
        (8..8).each do |i|
          p i,j
          pixel = img.pixel_color(i,j)
          r = pixel.red&0xff
          g = pixel.green&0xff
          b = pixel.blue&0xff
          p ['%x'%r, '%x'%g, '%x'%b]
          p [r, g, b]
          p ((306 * (r) + 601 * (g) + 117 * (b) + (1 << 9)) >> 10)
          p img.export_pixels_to_str(i, j, 1, 1, "I").ord
          p "x"
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
