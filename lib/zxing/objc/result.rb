module ZXing; end
module ZXing::ObjC; end

class ZXing::ObjC::Result
  include ZXing::Result

  def format
    native.barcodeFormat
  end

  def text
    native.text
  end

  def metadata
    native.metadata
  end

end
