module ZXing; end
module ZXing::ObjC; end

class ZXing::ObjC::Image 
  include ZXing::Image
  LuminanceSource = ZXing::ObjC::Common::CGImageLuminanceSource

  def self.read uri
    if !(String === uri)
      begin uri = uri.path; rescue ::Exception; end
    end

    if !(String === uri)
      begin uri = uri.to_s; rescue ::Exception; end
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
      img = ::ZXImage.alloc.initWithURL ::NSURL.alloc.initWithString(uri.to_s)
    rescue Exception => e
      raise ZXing::BadImageException.new e.message
    end

    self.new img
  end

  def rotate angle
    if angle == 0
      self
    else
      self.class.new @native.rotate(angle)
    end
  end

  def width
    @native.width
  end

  def height
    @native.height
  end

  def gray
    @native.export_pixels_to_str(0, 0, width, height, "I")
  end
end
