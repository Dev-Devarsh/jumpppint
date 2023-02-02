import 'dart:ui';

enum FFT { nunito }

enum FWT { light, regular, medium, semiBold, bold, extraBold }

class FontType {
  static getFontFamilyType(FFT? fontFamilyType) {
    switch (fontFamilyType) {
      case FFT.nunito:
        return "Nunito";
    }
  }

  static FontWeight getFontWeightType(FWT? fontWeightType) {
    switch (fontWeightType) {
      case FWT.light:
        return FontWeight.w300;
      case FWT.regular:
        return FontWeight.w400;
      case FWT.medium:
        return FontWeight.w500;
      case FWT.semiBold:
        return FontWeight.w600;
      case FWT.bold:
        return FontWeight.w700;
      case FWT.extraBold:
        return FontWeight.w800;
      default:
        return FontWeight.normal;
    }
  }
}
