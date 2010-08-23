module ZXing; end
module ZXing::FFI; end
module ZXing::FFI:QRCode; end

class ZXing::FFI::QRCode::Decoder < ZXing::FFI::Binarizer
  include ZXing::QRCode::Decoder
  def initialize luminance_source
    super ZXing::FFI::Library.Decoder_new(luminance_source.native), luminance_source
  end
end
