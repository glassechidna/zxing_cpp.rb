module ZXing; end
module ZXing::FFI; end

module ZXing::FFI::Library
  extend ::FFI::Library
  lib = File.join File.dirname(__FILE__), ".."
  lib = File.expand_path lib
  ffi_lib ::FFI::Library::LIBC, Dir[lib.to_s+"/zxing.{bundle,dylib,so,dll,sl}"][0]

  attach_function 'free', [:pointer], :void

  attach_function 'Reader_delete', [:pointer], :void
  attach_function 'Reader_decode', [:pointer,
                                    :pointer,
                                    :pointer], :pointer
  attach_function 'MultiFormatReader_new', [], :pointer
  attach_function 'DataMatrixReader_new', [], :pointer
  attach_function 'AztecReader_new', [], :pointer
  attach_function 'Code39Reader_new', [:bool, :bool], :pointer
  attach_function 'LuminanceSource_delete', [:pointer], :void
  attach_function 'LuminanceSource_width', [:pointer], :int
  attach_function 'LuminanceSource_height', [:pointer], :int
  attach_function 'LuminanceSource_matrix', [:pointer], :pointer
  attach_function 'GreyscaleLuminanceSource_new', [ :pointer,
                                                    :int,
                                                    :int,
                                                    :int,
                                                    :int,
                                                    :int,
                                                    :int
                                                  ], :pointer
  attach_function 'Binarizer_delete', [:pointer], :void
  attach_function 'Binarizer_black_matrix', [:pointer], :pointer
  attach_function 'HybridBinarizer_new', [:pointer], :pointer
  attach_function 'BitMatrix_get', [:pointer, :int, :int], :bool
  attach_function 'BinaryBitmap_new', [:pointer], :pointer
  attach_function 'BinaryBitmap_count', [:pointer], :int
  attach_function 'BinaryBitmap_delete', [:pointer], :void
  attach_function 'BinaryBitmap_black_matrix', [:pointer], :pointer
  attach_function 'DecodeHints_new', [:int], :pointer
  attach_function 'DecodeHints_default', [], :pointer
  attach_function 'DecodeHints_delete', [:pointer], :void
  attach_function 'DecodeHints_setTryHarder', [:pointer, :bool], :void
  attach_function 'DecodeHints_setDataMatrix', [:pointer, :bool], :void
  attach_function 'Result_delete', [:pointer], :void
  attach_function 'Result_getBarcodeFormat', [:pointer], :int
  attach_function 'Result_getText', [:pointer], :pointer
  attach_function 'BarcodeFormat_enum_to_string', [:int], :string
  attach_function 'String_delete', [:pointer], :void
  attach_function 'String_string', [:pointer], :string

  class ReaderPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::Reader_delete ptr
    end
  end

  class ResultPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::Result_delete ptr
    end
  end

  class LuminanceSourcePointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::LuminanceSource_delete ptr
    end
  end

  class BinarizerPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::Binarizer_delete ptr
    end
  end

  class BinaryBitmapPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::BinaryBitmap_delete ptr
    end
  end

  class DecodeHintsPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::DecodeHints_delete ptr
    end
  end

  class StringPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::String_delete ptr
    end
  end

  class BitMatrixPointer < FFI::AutoPointer
    def self.release ptr
      ZXing::FFI::Library::BitMatrix_delete ptr
    end
  end

end


