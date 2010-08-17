module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::Binarizer
  include ZXing::Binarizer
  def initialize ptr, source
    super ZXing::FFI::Library::BinarizerPointer.new ptr
    @source = source
  end
  attr_reader :source
  def black_matrix
    ZXing::FFI::Common::BitMatrix.new ZXing::FFI::Library.Binarizer_black_matrix(native)
  end
  def image
    width = source.width
    height = source.height
    image = Magick::Image.new width, height
    (0...height).each do |row|
      (0...width).each do |column|
        image.pixel_color(column, row, black_matrix.get(column, row) ? "black" : "white")
      end
    end
    return image
  end
end
