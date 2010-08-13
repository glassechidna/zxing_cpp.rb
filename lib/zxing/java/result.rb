module ZXing; end
module ZXing::Java; end

class ZXing::Java::Result
  include ZXing::Result

  def format
    # enum = ZXing::Java::FFI.Result_getBarcodeFormat @native
    # ZXing::Java::FFI.BarcodeFormat_enum_to_string enum
    native.barcode_format.to_s
  end

  def text
    native.text
  end

  def metadata
    native.resultMetadata
  end

end
