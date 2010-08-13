module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::Result
  include ZXing::Result

  def format
    enum = ZXing::CPP::FFI.Result_getBarcodeFormat @native
    ZXing::CPP::FFI.BarcodeFormat_enum_to_string enum
  end

  def text
    ZXing::CPP::FFI.String_string ZXing::CPP::FFI::StringPointer.new(ZXing::CPP::FFI.Result_getText(@native))
  end

  def metadata
  end

end
