import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/home/presentation/controllers/home_controller.dart';
import 'package:jumppoint_app/utills/colors.dart';

import '../../routes.dart';
import '../../utills/app_theme.dart';
import '../../utills/asset_images.dart';
import '../../utills/enum/font_type.dart';
import '../../utills/generated/locales.g.dart';
import '../../utills/utils.dart';

class CommonDrawer extends StatefulWidget {
  CommonDrawer({Key? key, required this.currentIndex,required this.onLogoutClick}) : super(key: key);
  RxInt currentIndex = 0.obs;
  VoidCallback onLogoutClick;

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [AppThemeState().commonBoxShadow()]),
        padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              PNGPath.horizontalLogo,
              height: 30,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              LocaleKeys.shipmentServices.tr,
              style: AppThemeState().customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 5,
            ),
            AppThemeState().commonDivider(),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.home.tr, 0, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.createShipment.tr, 1, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.batchShipment.tr, 2, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.reportExport.tr, 3, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.shipmentTracking.tr, 4, context),
            const SizedBox(
              height: 30,
            ),
            Text(
              LocaleKeys.otherServices.tr,
              style: AppThemeState().customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 5,
            ),
            AppThemeState().commonDivider(),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.topUpC.tr, 5, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.applyStickyWaybills.tr, 6, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.pickupPointList.tr, 7, context),
            const SizedBox(
              height: 30,
            ),
            Text(
              LocaleKeys.settings.tr,
              style: AppThemeState().customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              height: 5,
            ),
            AppThemeState().commonDivider(),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.accountSettings.tr, 8, context),
            const SizedBox(
              height: 12,
            ),
            onGetMenuItem(LocaleKeys.logout.tr, 9, context),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 5),
                  child: Text(
                    Utils.versionNo,
                    style: AppThemeState().customTextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onGetMenuItem(String title, int itemIndex, BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          widget.currentIndex.value = itemIndex;
          Get.back();
          onRedirectScreen(itemIndex, context);
        },
        child: Text(
          title,
          style: AppThemeState().customTextStyle(
              fontSize: 15,
              color: widget.currentIndex.value == itemIndex
                  ? AppColors.primaryColor
                  : AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ),
    );
  }

  void onRedirectScreen(int index, BuildContext context) async {
    switch (index) {
      case 0:
        Get.offNamed(
          RouteName.homePage,
        );
        widget.currentIndex.value = 0;
        break;
      case 1:
        Get.offAllNamed(
          RouteName.coTypePage,
        );
        widget.currentIndex.value = 1;
        break;
      case 2:
        Get.offNamed(
          RouteName.batchCreatePage,
        );
        widget.currentIndex.value = 2;
        break;
      case 3:
        Get.offNamed(
          RouteName.reportExport,
        );
        widget.currentIndex.value = 3;
        break;
      case 4:
        Get.offNamed(
          RouteName.shipmentTrackingPage,
        );
        widget.currentIndex.value = 4;
        break;
      case 5:
        Get.offAllNamed(
          RouteName.topUp,arguments: false
        );
        widget.currentIndex.value = 5;
        break;
      case 6:
        Get.offNamed(
          RouteName.applyWayBills,
        );
        widget.currentIndex.value = 6;
        break;
        case 7:
        Get.offNamed(
          RouteName.pickupPointsPage,
        );
        widget.currentIndex.value = 7;
        break;
      case 8:
        Get.offNamed(
          RouteName.settings,
        );
        widget.currentIndex.value = 8;
        break;
      case 9:
        // Logout and Clear all backend Pages
        print(" ${context.isPhone}");
        (context.isPhone)
            ? Utils.showCommonDialog(
                title: LocaleKeys.logoutMessage.tr,
                positiveText: LocaleKeys.logout.tr,
                negativeText: LocaleKeys.cancel.tr,
                isNegativeButtonShow: true,
                onNegativeTap: () {
                  Get.back();
                },
                onTap: () {
                  Get.find<HomeController>().logout();
                })
            : Utils.showCommonDialogWeb(
                title: LocaleKeys.logoutMessage.tr,
                positiveText: LocaleKeys.logout.tr,
                negativeText: LocaleKeys.cancel.tr,
                isNegativeButtonShow: true,
                onNegativeTap: () {
                  Get.back();
                },
                onTap: () {
                  Get.find<HomeController>().logout();
                });

        break;
      default:
        Get.offAllNamed(RouteName.root);
        break;
    }
  }
}
