// -*- c-basic-offset:2 -*-

#include <zxing/Reader.h>
#include <zxing/MultiFormatReader.h>
#include <zxing/datamatrix/DataMatrixReader.h>
#include <zxing/aztec/AztecReader.h>
#include <zxing/oned/Code39Reader.h>
#include <zxing/common/GreyscaleLuminanceSource.h>
#include <zxing/common/HybridBinarizer.h>
#include <zxing/FormatException.h>
#include <zxing/ReaderException.h>
#include <zxing/ChecksumException.h>
#include <zxing/common/reedsolomon/ReedSolomonException.h>
#include <zxing/common/IllegalArgumentException.h>
#include <zxing/common/Str.h>

#include <stdlib.h>
#include <stdint.h>

using namespace std;

extern "C" {
  void Reader_delete(void* reader_ptr) {
    zxing::Ref<zxing::Reader>* ref = (zxing::Ref<zxing::Reader>*)reader_ptr;
    delete ref;
  }

  void* new_exception_data(const char* className, std::exception const& e) {
    void** exception = (void**)malloc(sizeof(void*)*2);
    exception[0] = (void*)className;
    size_t size = strlen(e.what())+1;
    exception[1] = malloc(size);
    memcpy(exception[1], e.what(), size);
    return (void*)((uintptr_t)exception | 1);
  }

  void* Reader_decode(
    void* reader_ref_ptr,
    void* bitmap_ref_ptr,
    void* hints_ptr) {

    zxing::Ref<zxing::Reader>* reader =
      (zxing::Ref<zxing::Reader>*)reader_ref_ptr;
    zxing::Ref<zxing::BinaryBitmap>* bitmap = 
      (zxing::Ref<zxing::BinaryBitmap>*)bitmap_ref_ptr;
    zxing::DecodeHints* hints = (zxing::DecodeHints*)hints_ptr;
    void* result = 0;
    try {
      zxing::Ref<zxing::Result> decoded ((*reader)->decode(*bitmap, *hints));
      result = new zxing::Ref<zxing::Result>(decoded);
    } catch(zxing::IllegalArgumentException const& e) {
      result = new_exception_data("zxing::IllegalArgumentException", e);
    } catch(zxing::ReedSolomonException const& e) {
      result = new_exception_data("zxing::ReedSolomonException", e);
    } catch(zxing::FormatException const& e) {
      result = new_exception_data("zxing::FormatException", e);
    } catch(zxing::ChecksumException const& e) {
      result = new_exception_data("zxing::ChecksumException", e);
    } catch(zxing::ReaderException const& e) {
      result = new_exception_data("zxing::ReaderException", e);
    } catch(zxing::Exception const& e) {
      result = new_exception_data("zxing::Exception", e);
    } catch(...) {
      result = new_exception_data("...", std::exception());
    }
    return result;
  }

  void* MultiFormatReader_new() {
    zxing::MultiFormatReader* reader = new zxing::MultiFormatReader();
    return new zxing::Ref<zxing::Reader>(reader);
  }

  void* DataMatrixReader_new() {
    zxing::datamatrix::DataMatrixReader* reader = new zxing::datamatrix::DataMatrixReader();
    return new zxing::Ref<zxing::Reader>(reader);
  }

  void* AztecReader_new() {
    zxing::aztec::AztecReader* reader = new zxing::aztec::AztecReader();
    return new zxing::Ref<zxing::Reader>(reader);
  }

  void* Code39Reader_new(bool usingCheckDigit, bool extendedMode) {
    zxing::oned::Code39Reader* reader =
      new zxing::oned::Code39Reader(usingCheckDigit, extendedMode);
    return new zxing::Ref<zxing::Reader>(reader);
  }

  void LuminanceSource_delete(void* source_ptr) {
    zxing::Ref<zxing::LuminanceSource>* ref = (zxing::Ref<zxing::LuminanceSource>*)source_ptr;
    delete ref;
  }

  int LuminanceSource_width(void* source_ptr) {
    zxing::Ref<zxing::LuminanceSource>* ref = (zxing::Ref<zxing::LuminanceSource>*)source_ptr;
    return (*ref)->getWidth();
  }

  int LuminanceSource_height(void* source_ptr) {
    zxing::Ref<zxing::LuminanceSource>* ref = (zxing::Ref<zxing::LuminanceSource>*)source_ptr;
    return (*ref)->getHeight();
  }

  void* LuminanceSource_matrix(void* source_ptr) {
    zxing::Ref<zxing::LuminanceSource>* ref = (zxing::Ref<zxing::LuminanceSource>*)source_ptr;
    return &(*ref)->getMatrix()[0];
  }

  void* GreyscaleLuminanceSource_new(
    char* greyData,
    int dataWidth,
    int dataHeight,
    int left,
    int top,
    int width,
    int height) {
    zxing::GreyscaleLuminanceSource* source =
      new zxing::GreyscaleLuminanceSource(
        zxing::ArrayRef<char>(greyData, dataWidth*dataHeight),
        dataWidth,
        dataHeight,
        left,
        top,
        width,
        height);
    return new zxing::Ref<zxing::LuminanceSource>(source);
  }

  void Binarizer_delete(void* binarizer_ptr) {
    zxing::Ref<zxing::Binarizer>* ref = (zxing::Ref<zxing::Binarizer>*)binarizer_ptr;
    delete ref;
  }

  void* Binarizer_black_matrix(void* binarizer_ptr) {
    zxing::Ref<zxing::Binarizer>* ref = (zxing::Ref<zxing::Binarizer>*)binarizer_ptr;
    return new zxing::Ref<zxing::BitMatrix>((*ref)->getBlackMatrix());
  }

  void* BinaryBitmap_black_matrix(void* ref_ptr) {
    zxing::Ref<zxing::BinaryBitmap>* ref = (zxing::Ref<zxing::BinaryBitmap>*)ref_ptr;
    return new zxing::Ref<zxing::BitMatrix>((*ref)->getBlackMatrix());
  }

  bool BitMatrix_get(void* ref_ptr, int x, int y) {
    zxing::Ref<zxing::BitMatrix>* ref = (zxing::Ref<zxing::BitMatrix>*)ref_ptr;
    return (*ref)->get(x, y);
  }

  void* HybridBinarizer_new(zxing::Ref<zxing::LuminanceSource>* luminance_source) {
    zxing::HybridBinarizer* binarizer = new zxing::HybridBinarizer(*luminance_source);
    return new zxing::Ref<zxing::Binarizer>(binarizer);
  }

  void* BinaryBitmap_new(zxing::Ref<zxing::Binarizer>* binarizer) {
    zxing::BinaryBitmap* bitmap = new zxing::BinaryBitmap(*binarizer);
    return new zxing::Ref<zxing::BinaryBitmap>(bitmap);
  }

  int BinaryBitmap_count(void* bitmap_ptr) {
    zxing::Ref<zxing::BinaryBitmap>* ref = (zxing::Ref<zxing::BinaryBitmap>*)bitmap_ptr;
    return (*ref)->count();
  }

  void BinaryBitmap_delete(void* bitmap_ptr) {
    zxing::Ref<zxing::BinaryBitmap>* ref = (zxing::Ref<zxing::BinaryBitmap>*)bitmap_ptr;
    delete ref;
  }

  void* DecodeHints_new(int value) {
    return new zxing::DecodeHints(value);
  }

  void* DecodeHints_default() {
    return new zxing::DecodeHints(zxing::DecodeHints::DEFAULT_HINT);
  }

  void DecodeHints_delete(void* hints_ptr) {
    zxing::DecodeHints* hints  = (zxing::DecodeHints*)hints_ptr;
    delete hints;
  }

  void DecodeHints_setTryHarder(void* hints_ptr, bool value) {
    zxing::DecodeHints* hints  = (zxing::DecodeHints*)hints_ptr;
    hints->setTryHarder(value);
  }

  void DecodeHints_setDataMatrix(void* hints_ptr, bool) {
    zxing::DecodeHints* hints  = (zxing::DecodeHints*)hints_ptr;
    hints->addFormat(zxing::BarcodeFormat::DATA_MATRIX);
  }

  void Result_delete(void* result_ptr) {
    zxing::Ref<zxing::Result>* ref = (zxing::Ref<zxing::Result>*)result_ptr;
    delete ref;
  }

  int Result_getBarcodeFormat(void* ref_ptr) {
    zxing::Ref<zxing::Result>* ref = (zxing::Ref<zxing::Result>*)ref_ptr;
    return (*ref)->getBarcodeFormat();
  }

  void* Result_getText(void* ref_ptr) {
    zxing::Ref<zxing::Result>* ref = (zxing::Ref<zxing::Result>*)ref_ptr;
    zxing::Ref<zxing::String> string = (*ref)->getText();
    return new zxing::Ref<zxing::String>(string);
  }

  char const* BarcodeFormat_enum_to_string(zxing::BarcodeFormat format) {
    return zxing::BarcodeFormat::barcodeFormatNames[format];
  }

  void String_delete(void* string_ptr) {
    zxing::Ref<zxing::String>* ref = (zxing::Ref<zxing::String>*)string_ptr;
    delete ref;
  }

  char const* String_string(void* string_ptr) {
    zxing::Ref<zxing::String>* ref = (zxing::Ref<zxing::String>*)string_ptr;
    return (*ref)->getText().c_str();
  }

}

