import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/notification_center/presentation/controllers/notification_center_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';

class NotificationCenterView
    extends GetResponsiveView<NotificationCenterController> {
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
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.statusBarColor,
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.notificationCenter.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: AppColors.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => controller.notificationList.length > 0
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.notificationList.length,
                            itemBuilder: (context, index) {
                              return onGetRecordItem(index);
                            })
                        : Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                LocaleKeys.noNotification.tr,
                                style: _appTheme.customTextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondaryColor,
                                    fontWeightType: FWT.regular,
                                    fontFamilyType: FFT.nunito),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width/5),
            color: AppColors.primaryColor,
            child: CommonAppBar(
              title: LocaleKeys.notificationCenter.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 20,
              centerTitle: true,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width/5),
              child: SingleChildScrollView(
                child: Obx(
                  () => controller.notificationList.length > 0
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.notificationList.length,
                          itemBuilder: (context, index) {
                            return onGetRecordItem(index);
                          })
                      : Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              LocaleKeys.noNotification.tr,
                              style: _appTheme.customTextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondaryColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  onGetRecordItem(int index) {
    return Material(
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
          decoration: BoxDecoration(
            color: controller.notificationList[index].isRead
                ? AppColors.lightPrimaryColor
                : AppColors.whiteColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.notificationList[index].notificationTitle ?? "",
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "${controller.notificationList[index].date ?? ""}",
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
