import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/presentation/controllers/forgotpassword_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../widgets/common_button.dart';

class ForgotPasswordEmailView
    extends GetResponsiveView<ForgotPasswordController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();
  // Timer? future;

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
    /*future = Timer(const Duration(seconds: 5), () {
      Get.offNamed(RouteName.newPassWordPage);
    });*/
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  color: AppColors.backgroundColor,
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 700),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 100,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                      children: [
                        SvgPicture.asset(
                          SVGPath.mailSentIcon,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        onGetCustomText(LocaleKeys.emailSent.tr, 20,
                            AppColors.textPrimaryColor),
                        const SizedBox(
                          height: 25,
                        ),
                        onGetCustomText(LocaleKeys.emailSentLbl.tr, 16,
                            AppColors.textSecondaryColor),
                      ],
                    ),)
                  ),
                ),
              ),
            ),
            Container(
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  onGetCommonButton(LocaleKeys.resend.tr, AppColors.appBarColor,
                      AppColors.whiteColor, () {}),
                  onGetCommonButton(LocaleKeys.backToHome.tr,
                      AppColors.whiteColor, AppColors.appBarColor, () {
                    // future?.cancel();
                    Get.back();
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget? tablet() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(RouteName.newPassWordPage);
    });
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                color: AppColors.backgroundColor,
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 700),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 100,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                    children: [
                      SvgPicture.asset(
                        SVGPath.mailSentIcon,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      onGetCustomText(LocaleKeys.emailSent.tr, 20,
                          AppColors.textPrimaryColor),
                      const SizedBox(
                        height: 25,
                      ),
                      onGetCustomText(LocaleKeys.emailSentLbl.tr, 16,
                          AppColors.textSecondaryColor),
                    ],
                  ),)
              ),
                ),
            ),
          ),
          Container(
            color: AppColors.whiteColor,
            child: Column(
              children: [
                onGetCommonButton(LocaleKeys.resend.tr, AppColors.appBarColor,
                    AppColors.whiteColor, () {}),
                onGetCommonButton(LocaleKeys.backToHome.tr,
                    AppColors.whiteColor, AppColors.appBarColor, () {
                  // future?.cancel();
                  Get.back();
                }),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget? desktop() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(RouteName.newPassWordPage);
    });
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Container(
                  color: AppColors.backgroundColor,
                  width: Get.width / 3,
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 700),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 100,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                      children: [
                        SvgPicture.asset(
                          SVGPath.mailSentIcon,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        onGetCustomText(LocaleKeys.emailSent.tr, 20,
                            AppColors.textPrimaryColor),
                        const SizedBox(
                          height: 25,
                        ),
                        onGetCustomText(LocaleKeys.emailSentLbl.tr, 16,
                            AppColors.textSecondaryColor),
                      ],
                    ),)
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: Get.width / 3,
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  onGetCommonButton(LocaleKeys.resend.tr, AppColors.appBarColor,
                      AppColors.whiteColor, () {}),
                  onGetCommonButton(LocaleKeys.backToHome.tr,
                      AppColors.whiteColor, AppColors.appBarColor, () {
                    // future?.cancel();
                    Get.back();
                  }),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  onGetCustomText(String str, double fontSize, Color color) {
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

  onGetCommonButton(
      String str, Color color, Color txtColor, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
      child: CommonButton(
        buttonText: str,
        width: Get.width,
        backgroundColor: color,
        isBorder: false,
        textColor: txtColor,
        onTap: onTap,
      ),
    );
  }

}
