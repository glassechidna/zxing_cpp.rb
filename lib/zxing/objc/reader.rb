module ZXing; end
module ZXing::ObjC; end

class ZXing::ObjC::Reader
  include ZXing::Reader

  def decode bitmap, hints = nil
    hints ||= {}
    native_hints = ::ZXDecodeHints.new
    hints.each do |k, v|
      case k
      when :try_harder
        native_hints.tryHarder = v
      else
        raise "implement #{k} #{v}"
      end
    end
    return ZXing::Result.new native.decode(bitmap.native, hints:native_hints)
    # p ptr
    if (ptr.address & 1) != 0
      ptr = ObjC::Pointer.new(ptr.address & ~1)
      ptrs = ptr.read_array_of_pointer 2

      className = ptrs[0].read_string.sub(%r{^zxing},"ZXing")
      what = ptrs[1].read_string

      ZXing::ObjC::Library.free ptrs[1]
      ZXing::ObjC::Library.free ptr

      cls = className.split("::").inject(Object) { |parent, child| parent.const_get(child) }

      raise cls.new what
    end
    ZXing::Result.new ZXing::ObjC::Library::ResultPointer.new ptr
  end
end
