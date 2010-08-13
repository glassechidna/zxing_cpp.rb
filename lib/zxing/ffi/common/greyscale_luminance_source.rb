module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::GreyscaleLuminanceSource < ZXing::CPP::LuminanceSource
  def initialize image, left = nil, top = nil, width = nil, height = nil
    # need to hold on to the data for the C++ class
    @data = data = image.gray
    data_width = image.width
    data_height = image.height
    left == nil && left = 0
    top == nil && top = 0
    width == nil && width = image.width
    height == nil && height = image.height
    super ZXing::CPP::FFI.GreyscaleLuminanceSource_new(
                                                       data,
                                                       data_width,
                                                       data_height,
                                                       left,
                                                       top,
                                                       width,
                                                       height)
  end
  def image
    Magick::Image.constitute width, height, "I", matrix.get_array_of_char(0, width*height)
  end
end
