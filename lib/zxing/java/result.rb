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
    hash = {}
    if native.resultMetadata
      native.resultMetadata.keys.each do |key|
        hash[key.to_s] = native.resultMetadata.get(key)
      end
    end
    hash
  end

end
