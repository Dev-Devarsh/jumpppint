import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/template.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../../../utills/app_theme.dart';
import '../../../../../../utills/asset_images.dart';
import '../../../../../../utills/colors.dart';
import '../../../../../../utills/enum/font_type.dart';
import '../../../../../common/common_app_bar.dart';
import '../../../../../widgets/common_button.dart';
import '../../../../type/presentation/controllers/type_controller.dart';

class QrCodePermissionView extends GetResponsiveView<TypeController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();

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
    return Template(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.scanCode.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetCloseIcon(),
            leadingWidth: 27,
            centerTitle: true,
          ),
        ),
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              PNGPath.scanQRIcon,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              LocaleKeys.scanQrCode.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 22,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              LocaleKeys.cameraPermissionText.tr,
              textAlign: TextAlign.center,
              style: _appTheme.customTextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 15,
            ),
            CommonButton(
              buttonText: LocaleKeys.allow.tr,
              width: 270,
              backgroundColor: AppColors.primaryColor,
              isBorder: false,
              textColor: AppColors.whiteColor,
              onTap: () {
                // Get.offNamed(RouteName.scanQrCode,arguments: Get.arguments);
                controller.requestCameraPermission();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  LocaleKeys.cancel.tr,
                  textAlign: TextAlign.center,
                  style: _appTheme.customTextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget? tablet() {
    return Template(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.scanCode.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetCloseIcon(),
            leadingWidth: 27,
            centerTitle: true,
          ),
        ),
        alignment: AlignmentDirectional.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              PNGPath.scanQRIcon,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              LocaleKeys.scanQrCode.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 22,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              LocaleKeys.cameraPermissionText.tr,
              textAlign: TextAlign.center,
              style: _appTheme.customTextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 15,
            ),
            CommonButton(
              buttonText: LocaleKeys.allow.tr,
              width: 270,
              backgroundColor: AppColors.primaryColor,
              isBorder: false,
              textColor: AppColors.whiteColor,
              onTap: () {
                // Get.offNamed(RouteName.scanQrCode,arguments: Get.arguments);
                controller.requestCameraPermission();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  LocaleKeys.cancel.tr,
                  textAlign: TextAlign.center,
                  style: _appTheme.customTextStyle(
                      fontSize: 16,
                      color: AppColors.primaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget? desktop() {
    return Container();
  }

  // MOBILE

  onGetCloseIcon() {
    return InkWell(
      onTap: () {
        // Logger.dev("@71 Close Button Called");
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SvgPicture.asset(
          SVGPath.closeIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
