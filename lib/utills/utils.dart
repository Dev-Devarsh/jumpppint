import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:path_provider/path_provider.dart';

import '../routes.dart';
import 'app_theme.dart';
import 'colors.dart';
import 'enum/font_type.dart';
import 'generated/locales.g.dart';
import 'logger/logger.dart';

class Utils {
  static const String iosDeviceTypeId = "2";
  static const String androidDeviceTypeId = "1";

  static const String googleLoginTypeId = "google";
  static const String facebookLoginTypeId = "facebook";
  static const String appleLoginTypeId = "apple";
  static const String versionNo = "version 1.0.2";

  static const fileMaxSize = 15;

  static const animationDuration = Duration(milliseconds: 200);

  static displaySnackBar(String title, String message) {
    Logger.write('we are showing snack with $title $message');
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontType.getFontWeightType(FWT.medium),
          fontFamily: FontType.getFontFamilyType(FFT.nunito),
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontType.getFontWeightType(FWT.medium),
          fontFamily: FontType.getFontFamilyType(FFT.nunito),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static displayErrorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.textPrimaryColor,
        textColor: AppColors.whiteColor,
        fontSize: 16.0);
  }

  static displaySnackBarTop(String title, VoidCallback onAccept) {
    Logger.write('we are showing snack with $title');
    Get.snackbar(
      "",
      "",
      titleText: SizedBox(
        height: 1.h,
      ),
      messageText: Container(
        padding: EdgeInsets.fromLTRB(30.w, 9.h, 20.w, 10.h),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontType.getFontWeightType(FWT.medium),
            fontFamily: FontType.getFontFamilyType(FFT.nunito),
          ),
        ),
      ),
      onTap: (GetSnackBar? snackBar) {
        Get.back();
        onAccept.call();
      },
      backgroundColor: AppColors.primaryColor,
      isDismissible: false,
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.TOP,
    );
  }

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String getDeviceTypeID() {
    return Platform.isAndroid ? androidDeviceTypeId : iosDeviceTypeId;
  }

  static showSnackbar(dynamic message, {String title = ""}) {
    Get.snackbar(
      title,
      message.toString(),
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black54,
      borderRadius: 10,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static showCommonDialog(
      {String? title,
      required VoidCallback onTap,
      String? positiveText,
      String? negativeText,
      VoidCallback? onNegativeTap,
      bool? isNegativeButtonShow}) {
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Container(
          width: Get.width * 0.55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width * 0.52,
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: AppThemeState().customTextStyle(
                      fontSize: 14,
                      fontFamilyType: FFT.nunito,
                      color: AppColors.textPrimaryColor,
                      fontWeightType: FWT.regular),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AppThemeState().commonDivider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isNegativeButtonShow ?? false
                      ? Expanded(
                          child: InkWell(
                            onTap: onNegativeTap,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Align(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  negativeText ?? "",
                                  style: AppThemeState().customTextStyle(
                                      fontSize: 14,
                                      fontFamilyType: FFT.nunito,
                                      color: AppColors.textSecondaryColor,
                                      fontWeightType: FWT.regular),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                  isNegativeButtonShow ?? false
                      ? AppThemeState().commonVerticalDivider(45)
                      : const Offstage(),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            positiveText ?? "",
                            style: AppThemeState().customTextStyle(
                                fontSize: 14,
                                fontFamilyType: FFT.nunito,
                                color: AppColors.primaryColor,
                                fontWeightType: FWT.regular),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showProgressDialog({String? title}) {
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Container(
          width: 100,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.primaryColor,
                strokeWidth: 4,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title ?? 'Loading...',
                style: AppThemeState().customTextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showCommonDialogWeb(
      {String? title,
      required VoidCallback onTap,
      String? positiveText,
      String? negativeText,
      VoidCallback? onNegativeTap,
      bool? isNegativeButtonShow}) {
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Container(
          width: Get.width * 0.30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: Get.width * 0.52,
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: AppThemeState().customTextStyle(
                      fontSize: 14,
                      fontFamilyType: FFT.nunito,
                      color: AppColors.textPrimaryColor,
                      fontWeightType: FWT.regular),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AppThemeState().commonDivider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isNegativeButtonShow ?? false
                      ? Expanded(
                          child: InkWell(
                            onTap: onNegativeTap,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Align(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  negativeText ?? "",
                                  style: AppThemeState().customTextStyle(
                                      fontSize: 14,
                                      fontFamilyType: FFT.nunito,
                                      color: AppColors.textSecondaryColor,
                                      fontWeightType: FWT.regular),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                  isNegativeButtonShow ?? false
                      ? AppThemeState().commonVerticalDivider(45)
                      : const Offstage(),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Align(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            positiveText ?? "",
                            style: AppThemeState().customTextStyle(
                                fontSize: 14,
                                fontFamilyType: FFT.nunito,
                                color: AppColors.primaryColor,
                                fontWeightType: FWT.regular),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showUnauthorisedDialog(
      SharedPreferenceController sharedPreferenceController) {
    Utils.showCommonDialog(
        title: LocaleKeys.lblSessionExpired.tr,
        positiveText: LocaleKeys.btnSignIn.tr,
        onTap: () {
          sharedPreferenceController.logout();
          Get.offAllNamed(RouteName.root);
        },
        onNegativeTap: () {});
  }

  static getHeightSizedBox(double h) {
    return SizedBox(height: h);
  }

  static getWidthSizedBox(double w) {
    return SizedBox(width: w);
  }

  static int random(min, max) {
    return min + Random().nextInt(max - min);
  }

  static void openSetting() {
    // openAppSettings();
  }

  static String UTCtoLocalTime(String uTCTime) {
    if (uTCTime.isEmpty) {
      return "";
    }
    //debugPrint("uTCTime $uTCTime");
    try {
      var dateTime = DateTime.parse(uTCTime);
      var dateLocal = dateTime.toLocal();
      var dateFormat = DateFormat("h:mm aa").format(dateLocal);
      //debugPrint("uTCTime $dateFormat");
      return dateFormat;
    } catch (exception) {
      debugPrint("UTCtoLocalTime $exception");
      return "";
    }
  }

  static String apiDateFormet(String date){
    if (date.isEmpty) {
      return "";
    }
    try {
      var dateFormat = DateFormat("yyyy-MM-dd hh:mm").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date));
      //debugPrint("uTCTime $dateFormat");
      return dateFormat;
    } catch (exception) {
      debugPrint("UTCtoLocalTime $exception");
      return "";
    }
  }

    static String apiDateFormatByDate(String date){
    if (date.isEmpty) {
      return "";
    }
    try {
      var dateFormat = DateFormat("yyyy-MM-dd").format(DateFormat("yyyy-MM-dd'T'HH:mm").parse(date));
      //debugPrint("uTCTime $dateFormat");
      return dateFormat;
    } catch (exception) {
      debugPrint("UTCtoLocalTime $exception");
      return "";
    }
   }

  static String apiOrderDetailsDateFormat(String date){
    if (date.isEmpty) {
      return "";
    }
    try {
      var dateFormat = DateFormat("yyyy-MM-dd").format(DateFormat("yyyy-MM-dd HH:mm").parse(date));
      //debugPrint("uTCTime $dateFormat");
      return dateFormat;
    } catch (exception) {
      debugPrint("UTCtoLocalTime $exception");
      return "";
    }
  }


  static String apiDateFormatForShipmentDetails(String date){
    if (date.isEmpty) {
      return "";
    }
    try {
      var dateFormat = DateFormat("yyyy-MM-dd").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date));
      //debugPrint("uTCTime $dateFormat");
      return dateFormat;
    } catch (exception) {
      debugPrint("UTCtoLocalTime $exception");
      return "";
    }
  }


  static Future<Directory?> getTempDirectory() {
    return getTemporaryDirectory();
    //return DownloadsPathProvider.downloadsDirectory;
  }
}

DateTime? loginClickTime;

bool isRedundentClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    // print("first click");
    return false;
  }
  // print('diff is ${currentTime.difference(loginClickTime!).inSeconds}');
  if (currentTime.difference(loginClickTime!).inSeconds < 1) {
    //set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}


