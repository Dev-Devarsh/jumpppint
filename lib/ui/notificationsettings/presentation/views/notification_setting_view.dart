import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/notificationsettings/presentation/controllers/notification_settings_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';

class NotificationSettingsView
    extends GetResponsiveView<NotificationSettingsController> {
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
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.notificationLbl.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: AnimationLimiter(
                      child: Column(
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
                        onNotificationTextFormField(),
                        const SizedBox(
                          height: 5,
                        ),
                        onGetShipmentStatus(),
                        const SizedBox(
                          height: 15,
                        ),
                        onGetPromotion(),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 8,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              color: AppColors.primaryColor,
              child: CommonAppBar(
                title: LocaleKeys.notificationLbl.tr,
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 50,
                centerTitle: true,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Get.width / 5),
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Form(
                        key: formKey,
                        child: AnimationLimiter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              onNotificationTextFormField(),
                              const SizedBox(
                                height: 5,
                              ),
                              onGetShipmentStatus(),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetPromotion(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  onNotificationTextFormField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          LocaleKeys.pushNotificationLbl.tr,
          textAlign: TextAlign.left,
          style: AppThemeState().customTextStyle(
              fontSize: 14,
              color: AppColors.secondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ),
    );
  }

  onGetShipmentStatus() {
    return Obx(() => Container(
          width: Get.width,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: AppColors.borderColor),
          ),
          child: InkWell(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocaleKeys.shipmentStatus.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
                Switch(
                  // thumb color (round icon)
                  activeColor: AppColors.primaryColor,
                  activeTrackColor: AppColors.switchActiveTrackColor,
                  inactiveThumbColor: AppColors.whiteColor,
                  inactiveTrackColor: AppColors.switchInactiveTrackColor,
                  splashRadius: 50.0,
                  value: controller.isShipmentStatus.value,
                  onChanged: (value) {
                    controller.shipmentStatusUpdate(value);
                  },
                ),
                /*const SizedBox(
                  width: 10,
                ),
                controller.isShipmentStatus.value
                    ? SvgPicture.asset(
                        SVGPath.rightIcon,
                        width: 12,
                        color: controller.isShipmentStatus.value == true
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                      )
                    : Container(),*/
              ],
            ),
            onTap: () {
              controller.isShipmentStatus.value =
                  !controller.isShipmentStatus.value;
            },
          ),
        ));
  }

  onGetPromotion() {
    return Obx(() => Container(
          width: Get.width,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: AppColors.borderColor),
          ),
          child: InkWell(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocaleKeys.promotion.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
                Switch(
                  // thumb color (round icon)
                  activeColor: AppColors.primaryColor,
                  activeTrackColor: AppColors.switchActiveTrackColor,
                  inactiveThumbColor: AppColors.whiteColor,
                  inactiveTrackColor: AppColors.switchInactiveTrackColor,
                  splashRadius: 50.0,
                  value: controller.isPromotion.value,
                  onChanged: (value) {
                    controller.promotionStatusUpdate(value);
                  },
                ),
                /*  const SizedBox(
                  width: 10,
                ),
                controller.isPromotion.value
                    ? SvgPicture.asset(
                        SVGPath.rightIcon,
                        width: 12,
                        color: controller.isPromotion.value == true
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                      )
                    : Container(),*/
              ],
            ),
            onTap: () {
              controller.isPromotion.value = !controller.isPromotion.value;
            },
          ),
        ));
  }
}
