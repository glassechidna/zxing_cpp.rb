module ZXing; end
module ZXing::Java; end
module ZXing::Java::QRCode; end
module ZXing::Java::QRCode::Encoder; end

module ZXing::Java::QRCode::Encoder::Encoder
  include ZXing::QRCode::Encoder::Encoder
  def self.encode *args
    content = args.shift
    ecl = args.shift
    hints = {}
    if args.length == 2
      hints = args.shift
    end
    qrcode = args.shift

    case
    when ecl == "l" || ecl == :l; ecl = Java::com::google::zxing::qrcode::decoder::ErrorCorrectionLevel::L
    when ecl == "h" || ecl == :h; ecl = Java::com::google::zxing::qrcode::decoder::ErrorCorrectionLevel::H
    when ecl == "q" || ecl == :q; ecl = Java::com::google::zxing::qrcode::decoder::ErrorCorrectionLevel::Q
    when ecl == "m" || ecl == :m; ecl = Java::com::google::zxing::qrcode::decoder::ErrorCorrectionLevel::M
    else; raise "bad error correction level: #{ecl}"
    end

    hashTable = java::util::Hashtable.new
    hints.each do |k,v|
      # tested?
      case
      when k == :character_set || k == "character_set"
        k = Java::com::google::zxing::EncodeHintType::CHARACTER_SET
        v = v
        hashTable.put k, v
      end
    end
    hints = hashTable
    
    Java::com::google::zxing::qrcode::encoder::Encoder.encode content, ecl, hints, qrcode.native
  end
end
