module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::Result
  include ZXing::Result

  def format
    enum = ZXing::FFI::Library.Result_getBarcodeFormat @native
    ZXing::FFI::Library.BarcodeFormat_enum_to_string enum
  end

  def text
    ZXing::FFI::Library.String_string ZXing::FFI::Library::StringPointer.new(ZXing::FFI::Library.Result_getText(@native))
  end

  def metadata
  end

end
