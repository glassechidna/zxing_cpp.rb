module ZXing; end
module ZXing::FFI; end
module ZXing::FFI:QRCode; end

class ZXing::FFI::QRCode::Detector < ZXing::FFI::Binarizer
  include ZXing::QRCode::Detector
  def initialize luminance_source
    super ZXing::FFI::Library.Detector_new(luminance_source.native), luminance_source
  end
end
