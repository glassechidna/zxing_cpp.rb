module ZXing; end
module ZXing::CPP; end

class ZXing::CPP::Reader
  include ZXing::Reader
  def initialize ptr
    super ZXing::CPP::FFI::ReaderPointer.new ptr
  end

  def decode bitmap, hints = {}
    native_hints = ZXing::CPP::FFI::
      DecodeHintsPointer.new(ZXing::CPP::FFI.DecodeHints_new(0))
    hints.each do |k, v|
      case k
      when :try_harder
        ZXing::CPP::FFI.DecodeHints_setTryHarder native_hints, v
      else
        raise "implement #{k} #{v}"
      end
    end
    # p @native, bitmap.native, native_hints
    ptr = ZXing::CPP::FFI.Reader_decode @native, bitmap.native, native_hints
    # p ptr
    if (ptr.address & 1) != 0
      ptr = FFI::Pointer.new(ptr.address & ~1)
      ptrs = ptr.read_array_of_pointer 2

      className = ptrs[0].read_string.sub(%r{^zxing},"ZXing")
      what = ptrs[1].read_string

      ZXing::CPP::FFI.free ptrs[1]
      ZXing::CPP::FFI.free ptr

      cls = className.split("::").inject(Object) { |parent, child| parent.const_get(child) }

      raise cls.new what
    end
    ZXing::Result.new ZXing::CPP::FFI::ResultPointer.new ptr
  end
end
