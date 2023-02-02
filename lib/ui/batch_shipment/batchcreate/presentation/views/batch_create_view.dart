import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/custom_drawer.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

import '../../../../../routes.dart';
import '../controllers/batch_create_controller.dart';

class BatchCreateView extends GetResponsiveView<BatchCreateController> {
  final AppThemeState _appTheme = AppThemeState();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.batchCreate.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetBackIcon(),
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        drawer: Drawer(
          child: CommonDrawer(currentIndex: RxInt(2), onLogoutClick: () {
            controller.logout();
          },),
        ),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Expanded(child: onGetOrderList(false)),
              onBottomButton(false)
            ],
          ),
        ));
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 2,
        body: Column(
          children: [
            CommonAppBar(
              title: LocaleKeys.batchCreate.tr,
              elevation: 0.0,
              isBackButtonVisible: false,
              leadingWidth: 45,
              centerTitle: true,
            ),
            Expanded(child: onGetOrderList(true)),
            onBottomButton(true)
          ],
        ));
  }

  onGetBackIcon() {
    return InkWell(
      onTap: () {
        scaffoldKey.currentState!.openDrawer();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SvgPicture.asset(
          SVGPath.drawerIcon,
          width: 25,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  onBottomButton(bool isWeb) {
    return Container(
      width: Get.width,
      color: AppColors.whiteColor,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: isWeb ? Get.width / 5 : 10),
            child: onGetBatchButton("Upload shipment .xlsx (Max 300 records)",
                AppColors.appBarColor, AppColors.whiteColor, isWeb, () {
              Get.toNamed(RouteName.confirmShipment);
            }),
          ),
          onGetBatchButton(LocaleKeys.download.tr, AppColors.whiteColor,
              AppColors.appBarColor, isWeb, () {
            Get.toNamed(RouteName.bulkOrderPreviewPage);
          }),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  onGetBatchButton(
      String str, Color color, Color txtColor, bool isWeb, VoidCallback onTap) {
    return CommonButton(
      padding: const EdgeInsets.only(left: 10, right: 10),
      buttonText: str,
      width: Get.width,
      backgroundColor: color,
      isBorder: false,
      textColor: txtColor,
      onTap: onTap,
    );
  }

  onGetOrderList(bool isWeb) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: AnimationLimiter(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 700),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            index == 0
                                ? LocaleKeys.batchCreateAt
                                    .trParams({'batchCreateAt': '2022-03-28'})
                                : LocaleKeys.batchCreateAt
                                    .trParams({'batchCreateAt': '2022-02-21'}),
                            style: _appTheme.customTextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondaryColor,
                                fontWeightType: FWT.regular,
                                fontFamilyType: FFT.nunito),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: index == 0 ? 1 : 3,
                              itemBuilder: (context, index) {
                                return onGetOrderListItem(index);
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  onGetOrderListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screen.isDesktop ? Get.width/5:10,vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [onGetOrderDetails(index), onGetOrderClick()],
      ),
    );
  }

  onGetOrderDetails(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        RichText(
          text: TextSpan(
            text: LocaleKeys.createAt.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
            children: <TextSpan>[
              TextSpan(
                  text: ' 2022-03-28 18:18',
                  style: TextStyle(color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: LocaleKeys.parcelNo.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
            children: <TextSpan>[
              TextSpan(
                  text: ' 3',
                  style: TextStyle(color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: LocaleKeys.statusBatch.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
            children: <TextSpan>[
              TextSpan(
                  text: getStatus(index),
                  style: TextStyle(color: getStatusColor(getStatus(index)))),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  getStatusColor(String? orderStatus) {
    Color orderTypeStr;
    switch (orderStatus) {
      case "Completed":
        orderTypeStr = AppColors.greenColor;
        break;
      case "Scheduled":
        orderTypeStr = AppColors.textOrangeColor;
        break;
      case "Rejected":
        orderTypeStr = AppColors.textRedColor;
        break;
      case "Canceled":
        orderTypeStr = AppColors.textSecondaryColor;
        break;
      default:
        orderTypeStr = AppColors.textSecondaryColor;
        break;
    }
    return orderTypeStr;
  }

  getStatus(int? orderStatus) {
    String orderTypeStr;
    switch (orderStatus) {
      case 0:
        orderTypeStr = "Completed";
        break;
      case 1:
        orderTypeStr = "Scheduled";
        break;
      case 2:
        orderTypeStr = "Rejected";
        break;
      case 3:
        orderTypeStr = "Canceled";
        break;
      default:
        orderTypeStr = "Completed";
        break;
    }
    return orderTypeStr;
  }

  onGetOrderClick() {
    return Column(
      children: [
        AppThemeState().commonDivider(),
        InkWell(
          onTap: () {
            Get.toNamed(RouteName.shipmentTrackingPage);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
            child: Text(
              LocaleKeys.details.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 16,
                  color: AppColors.appBarColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ).paddingSymmetric(vertical: 12),
          ),
        ),
      ],
    );
  }
}
