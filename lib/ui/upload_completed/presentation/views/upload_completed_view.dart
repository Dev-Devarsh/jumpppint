import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:jumppoint_app/routes.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/asset_images.dart';
import '../../../../utills/colors.dart';
import '../../../../utills/enum/font_type.dart';
import '../../../../utills/generated/locales.g.dart';
import '../controllers/upload_completed_controller.dart';

class UploadCompletedView extends GetResponsiveView<UploadCompletedController> {
  @override
  Widget? builder() {
    if (screen.isPhone) {
      return phone();
    } else if (screen.isTablet) {
      return tablet();
    } else if (screen.isDesktop) {
      return desktop();
    } else {
      return phone();
    }
  }

  @override
  Widget? phone() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SVGPath.mailSentIcon,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    onCommonTextFormField(LocaleKeys.uploadCompleted.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormField(LocaleKeys.uploadCompletedMsg.tr, 16,
                        AppColors.textSecondaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormFieldWithBack(LocaleKeys.backToTopUpPage.tr, 16,
                        AppColors.primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget? tablet() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SVGPath.mailSentIcon,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    onCommonTextFormField(LocaleKeys.uploadCompleted.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormField(LocaleKeys.uploadCompletedMsg.tr, 16,
                        AppColors.textSecondaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormFieldWithBack(LocaleKeys.backToTopUpPage.tr, 16,
                        AppColors.primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget? desktop() {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                color: AppColors.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SVGPath.mailSentIcon,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    onCommonTextFormField(LocaleKeys.uploadCompleted.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormField(LocaleKeys.uploadCompletedMsg.tr, 16,
                        AppColors.textSecondaryColor),
                    const SizedBox(
                      height: 20,
                    ),
                    onCommonTextFormFieldWithBack(LocaleKeys.backToTopUpPage.tr, 16,
                        AppColors.primaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Center(
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: AppThemeState().customTextStyle(
            fontSize: fontSize,
            color: color,
            // color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onCommonTextFormFieldWithBack(String str, double fontSize, Color color) {
    return Center(
      child: InkWell(
        onTap: (){
          Get.offNamedUntil(RouteName.topUp,(route) => (route.settings.name == RouteName.topUp));
        },
        child: Text(
          str,
          textAlign: TextAlign.center,
          style: AppThemeState().customTextStyle(
              fontSize: fontSize,
              color: color,
              // color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ),
    );
  }

}
