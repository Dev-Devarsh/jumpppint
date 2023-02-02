import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account/presentation/controllers/apply_for_account_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';

class ApplyForAccountDoneView
    extends GetResponsiveView<ApplyForAccountController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                      height: 10,
                    ),
                    onCommonTextFormField(LocaleKeys.registrationDone.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 14,
                    ),
                    onCommonTextFormField(LocaleKeys.jumpPointUser.tr, 16,
                        AppColors.textSecondaryColor),
                    const SizedBox(
                      height: 10,
                    ),
                    onCommonTextFormField(
                        LocaleKeys.home.tr, 16, AppColors.primaryColor,
                        isBackHome: true),
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
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                      height: 10,
                    ),
                    onCommonTextFormField(LocaleKeys.registrationDone.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 14,
                    ),
                    onCommonTextFormField(LocaleKeys.jumpPointUser.tr, 16,
                        AppColors.textSecondaryColor),
                    const SizedBox(
                      height: 10,
                    ),
                    onCommonTextFormField(
                        LocaleKeys.home.tr, 16, AppColors.primaryColor,
                        isBackHome: true),
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
    print("TempLate");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                      height: 10,
                    ),
                    onCommonTextFormField(LocaleKeys.registrationDone.tr, 20,
                        AppColors.textPrimaryColor),
                    const SizedBox(
                      height: 14,
                    ),
                    onCommonTextFormField(LocaleKeys.jumpPointUser.tr, 16,
                        AppColors.textSecondaryColor),
                    const SizedBox(
                      height: 10,
                    ),
                    onCommonTextFormField(
                        LocaleKeys.home.tr, 16, AppColors.primaryColor,
                        isBackHome: true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onCommonTextFormField(String str, double fontSize, Color color,
      {bool isBackHome = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Center(
        child: InkWell(
          onTap: () {
            if (isBackHome) Get.offAllNamed(RouteName.homePage);
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
      ),
    );
  }
}
