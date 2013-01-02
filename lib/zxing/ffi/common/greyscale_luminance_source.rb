module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::Common::GreyscaleLuminanceSource < ZXing::FFI::LuminanceSource
  def initialize image, left = nil, top = nil, width = nil, height = nil
    data = image.gray
    data_width = image.width
    data_height = image.height
    left == nil && left = 0
    top == nil && top = 0
    width == nil && width = image.width
    height == nil && height = image.height
    super ZXing::FFI::Library.GreyscaleLuminanceSource_new(
                                                           data,
                                                           data_width,
                                                           data_height,
                                                           left,
                                                           top,
                                                           width,
                                                           height)
  end
  def image
    Magick::Image.constitute(width,
                             height, 
                             "I",
                             matrix.get_array_of_char(0, width*height).map{|v|
                               v << 8
                             })
  end
end
