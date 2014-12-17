module ZXing; end
module ZXing::FFI; end

class ZXing::FFI::Reader
  include ZXing::Reader
  def initialize ptr
    super ZXing::FFI::Library::ReaderPointer.new ptr
  end

  def decode bitmap, hints = nil
    hints ||= {}
    th = hints[:try_harder]
    hints.delete :try_harder
    native_hints = nil
    if hints.empty?
      native_hints = ZXing::FFI::Library::DecodeHintsPointer.new(ZXing::FFI::Library.DecodeHints_default)
    else
      native_hints = ZXing::FFI::Library::DecodeHintsPointer.new(ZXing::FFI::Library.DecodeHints_new(0))
      hints.each do |k, v|
        case k
        when :possible_formats
          v.each do |format|
            case format 
            when :DATA_MATRIX
              ZXing::FFI::Library.
                DecodeHints_setDataMatrix native_hints, true
            else
              raise "implement hint for #{format}"
            end
          end
        else
          raise "implement #{k} #{v}"
        end
      end
    end
    if th
      ZXing::FFI::Library.DecodeHints_setTryHarder native_hints, th
    end
    # p @native, bitmap.native, native_hints
    ptr = ZXing::FFI::Library.Reader_decode @native, bitmap.native, native_hints
    # p ptr
    if (ptr.address & 1) != 0
      ptr = FFI::Pointer.new(ptr.address & ~1)
      ptrs = ptr.read_array_of_pointer 2

      className = ptrs[0].read_string.sub(%r{^zxing},"ZXing")
      what = ptrs[1].read_string

      ZXing::FFI::Library.free ptrs[1]
      ZXing::FFI::Library.free ptr

      cls = className.split("::").inject(Object) { |parent, child| parent.const_get(child) }

      raise cls.new what
    end
    ZXing::Result.new ZXing::FFI::Library::ResultPointer.new ptr
  end
end
