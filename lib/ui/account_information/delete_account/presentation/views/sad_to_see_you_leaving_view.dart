import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../../utills/generated/locales.g.dart';
import '../../../../common/template_web.dart';
import '../controlleres/delete_account_controller.dart';

class SadToSeeYouLeavingView
    extends GetResponsiveView<DeleteAccountController> {
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
            child: commonSadScreenDetails(),
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
            child: commonSadScreenDetails(),
          ),
        ],
      ),
    );
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
      currentTab: 0,
      body: Scaffold(
        key: scaffoldKey,
        body: Column(
          children: [
            Expanded(child: commonSadScreenDetails()),
          ],
        ),
      ),
    );
  }

  commonSadScreenDetails() {
    return Container(
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
          onCommonTextFormField(
              LocaleKeys.sadToSeeLeave.tr, 22, AppColors.textPrimaryColor),
          const SizedBox(
            height: 20,
          ),
          Obx(() => onCommonTextFormField(
              LocaleKeys.sendEmailTo.trParams({'email':controller.userData.value?.email??""}), 16, AppColors.textSecondaryColor)),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              controller.backToHome();
            },
            child: onCommonTextFormField(
                LocaleKeys.backToHome.tr, 16, AppColors.primaryColor),
          )
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
}
