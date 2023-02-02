import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'asset_images.dart';
import 'colors.dart';
import 'enum/font_type.dart';
import 'logger/logger.dart';

///
/// This class contains all UI related styles
///
class AppTheme extends StatefulWidget {
  final Widget? child;

  const AppTheme({Key? key, @required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppThemeState();
  }

  static AppThemeState of(BuildContext context) {
    final _InheritedStateContainer? inheritedStateContainer =
        context.dependOnInheritedWidgetOfExactType();
    if (inheritedStateContainer == null) {
      return AppThemeState();
    } else {
      return inheritedStateContainer.data!;
    }
  }
}

class AppThemeState extends State<AppTheme> {
  ///
  /// Mention height and width which are mentioned in your design file(i.e XD)
  /// to maintain ratio for all other devices
  ///

  static double get expectedDeviceWidth => onGetWidth();

  static double get expectedDeviceHeight => onGetHeight();

  String fontExtraBold = "NunitoExtraBold";
  String fontBold = "NunitoBold";
  String fontSemiBold = "NunitoSemiBold";

  String fontMedium = "NunitoMedium";

  TextStyle customTextStyle(
      {double fontSize = 12,
      Color? color,
      FWT? fontWeightType,
      FFT? fontFamilyType,
      double? height,
      TextDecoration? decoration,
      FontStyle? fontStyle}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontType.getFontWeightType(fontWeightType),
        fontFamily: FontType.getFontFamilyType(fontFamilyType),
        fontSize: (fontSize),
        fontStyle: fontStyle,
        height: 1.5,
        color: color);
  }

  static TextStyle myTextStyle(
      {double fontSize = 12,
      Color? color,
      FWT? fontWeightType,
      FFT? fontFamilyType,
      TextDecoration? decoration,
      FontStyle? fontStyle}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontType.getFontWeightType(fontWeightType),
        fontFamily: FontType.getFontFamilyType(fontFamilyType),
        fontSize: (fontSize).sp,
        fontStyle: fontStyle,
        color: color);
  }

  BoxShadow commonBoxShadow() {
    return const BoxShadow(
      color: Color(0x0c000000),
      blurRadius: 20,
      offset: Offset(0, 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Logger.write('@77 build App Theme again');
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  InputDecoration chatInputDecoration(Color fillColor) => InputDecoration(
        filled: false,
        fillColor: fillColor,
        counter: null,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        // focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      );

  TextStyle textStyleMontMedium(
      {double fontSize = 12, Color? color, TextDecoration? decoration}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontWeight.w400,
        fontFamily: FontType.getFontFamilyType(FFT.nunito),
        fontSize: fontSize.sp,
        color: color);
  }

  TextStyle textStyleMontSemiBold(
      {double fontSize = 12, Color? color, TextDecoration? decoration}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontWeight.w600,
        fontFamily: FontType.getFontFamilyType(FFT.nunito),
        fontSize: fontSize.sp,
        color: color);
  }

  TextStyle textStyleMontBold(
      {double fontSize = 12, Color? color, TextDecoration? decoration}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontWeight.w700,
        fontFamily: FontType.getFontFamilyType(FFT.nunito),
        fontSize: fontSize.sp,
        color: color);
  }

  TextStyle textStyleMontRegular(
      {double fontSize = 12, Color? color, TextDecoration? decoration}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: FontType.getFontWeightType(FWT.regular),
        fontFamily: FontType.getFontFamilyType(FFT.nunito),
        fontSize: fontSize.sp,
        color: color);
  }

  static onGetWidth() {
    if (Get.width >= 1000) {
      return 1440.0;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (Get.width >= 800) {
      return 834.0;
    }
    // Or less then that we called it mobile
    else {
      return 375.0;
    }
  }

  static onGetHeight() {
    if (Get.height >= 1000) {
      return 1024.0;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (Get.height >= 800) {
      return 1194.0;
    }
    // Or less then that we called it mobile
    else {
      return 812.0;
    }
  }

  commonDivider() {
    return Container(
      width: Get.width,
      height: 1,
      color: AppColors.borderColor,
    );
  }

  commonVerticalDivider(double height) {
    return Container(
      width: 1,
      height: height,
      color: AppColors.borderColor,
    );
  }

  commonBorder() {
    return Border.all(
      color: AppColors.borderColor,
      width: 1,
    );
  }

  commonDropDownDecoration(String labelText,{String? errorText }) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      errorMaxLines: 3,
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.5),
        child: SvgPicture.asset(
          SVGPath.dropDownIcon,
          color: AppColors.textSecondaryColor,
        ),
      ),
      errorStyle: AppThemeState().customTextStyle(
          fontSize: errorText == null ? 0.4 : 12,//12,
           fontFamilyType: FFT.nunito,
          color: AppColors.primaryColor,
          fontWeightType: FWT.regular),
      labelText: labelText,
      labelStyle: AppThemeState().customTextStyle(
          fontSize: 14,
          fontFamilyType: FFT.nunito,
          color: AppColors.textSecondaryColor,
          fontWeightType: FWT.regular),
      filled: true,
      fillColor: AppColors.backgroundColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: AppColors.borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1,
          )),
      errorText: errorText,
       border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
    );
  }

  errorStyle(double size) {
    return AppThemeState().customTextStyle(
        fontSize: size,
        fontFamilyType: FFT.nunito,
        color: AppColors.primaryColor,
        fontWeightType: FWT.regular);
  }

  dropdownLabelStyle() {
    return AppThemeState().customTextStyle(
        fontSize: 14,
        fontFamilyType: FFT.nunito,
        color: AppColors.textSecondaryColor,
        fontWeightType: FWT.regular);
  }

  enableBorderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: AppColors.borderColor, width: 1),
    );
  }

  focusBorderStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 1,
        ));
  }

  borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: AppColors.borderColor,
        width: 1,
      ),
    );
  }

  errorBorderStyle(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    );
  }

  onGetBackButton() {
    return InkWell(
      onTap: () {
        Get.back();
        // scaffoldKey.currentState!.openDrawer();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
        child: SvgPicture.asset(
          SVGPath.backIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppThemeState? data;

  _InheritedStateContainer({
    Key? key,
    @required this.data,
    @required Widget? child,
  })  : assert(child != null),
        super(key: key, child: child!);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
