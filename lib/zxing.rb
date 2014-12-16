module ZXing
  autoload :Common, 'zxing/common'

  autoload :FFI, 'zxing/ffi'
  autoload :RMagick, 'zxing/rmagick'

  autoload :Image, 'zxing/image'

  autoload :Reader, 'zxing/reader'
  autoload :MultiFormatReader, 'zxing/multi_format_reader'
  autoload :Result, 'zxing/result'
  autoload :LuminanceSource, 'zxing/luminance_source'
  autoload :BinaryBitmap, 'zxing/binary_bitmap'
  autoload :Binarizer, 'zxing/binarizer'

  autoload :Exception, 'zxing/exception'
  autoload :BadImageException, 'zxing/bad_image_exception'
  autoload :NotFoundException, 'zxing/not_found_exception'
  autoload :ReedSolomonException, 'zxing/reed_solomon_exception'
  autoload :ReaderException, 'zxing/reader_exception'
  autoload :IllegalArgumentException, 'zxing/illegal_argument_exception'
  autoload :ChecksumException, 'zxing/checksum_exception'
  autoload :FormatException, 'zxing/format_exception'

  autoload :DataMatrix, 'zxing/datamatrix'
  autoload :OneD, 'zxing/oned'
  autoload :Common, 'zxing/common'
  autoload :PDF417, 'zxing/pdf417'
  autoload :QRCode, 'zxing/qrcode'
  autoload :Aztec, 'zxing/aztec'

  def decode *args
    begin
      decode!(*args)
    rescue Exception => e
      nil
    end
  end

  def decode! argument, hints = nil
    image = Image.read argument
    source = LuminanceSource.new image
    binarizer = Common::HybridBinarizer.new source
    bitmap = BinaryBitmap.new binarizer
    ZXing::MultiFormatReader.new.decode(bitmap, hints).text
  end

  module_function :decode, :decode!

end
