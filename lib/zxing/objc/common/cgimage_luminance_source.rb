module ZXing; end
module ZXing::ObjC; end
module ZXing::ObjC::Common; end

class ZXing::ObjC::Common::CGImageLuminanceSource < ZXing::ObjC::LuminanceSource
  def initialize image, left = nil, top = nil, width = nil, height = nil
    left.nil? and left = 0
    top.nil? and top = 0
    width.nil? and width = image.width
    height.nil? and height = image.height

    super ::ZXCGImageLuminanceSource.alloc.initWithImage(image.native,
                                                         left:left,
                                                         top:top,
                                                         width:width,
                                                         height:height)
  end
  def image
    raise "implement"
    Magick::Image.constitute width, height, "I", matrix.get_array_of_char(0, width*height)
  end
end
