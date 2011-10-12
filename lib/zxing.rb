module ZXing
  autoload :Common, 'zxing/common'

  autoload :Java, 'zxing/java'
  autoload :FFI, 'zxing/ffi'
  autoload :ObjC, 'zxing/objc'
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

  if !defined? RUBY_ENGINE or RUBY_ENGINE != "macruby"
    def decode *args
      begin
        p args
        raise "hell"
        decode!(*args)
      rescue Exception => e
        nil
      end
    end

    def decode! argument
      image = Image.read argument
      source = LuminanceSource.new image
      binarizer = Common::HybridBinarizer.new source
      bitmap = BinaryBitmap.new binarizer
      ZXing::MultiFormatReader.new.decode(bitmap).text
    end

    module_function :decode, :decode!
  end

end
