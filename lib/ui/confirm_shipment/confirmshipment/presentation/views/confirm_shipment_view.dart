import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/presentation/controllers/confirm_shipment_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/utils.dart';

class ConfirmShipmentView extends GetResponsiveView<ConfirmShipmentController> {
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
        child: Container(
          color: AppColors.appBarColor,
          padding: EdgeInsets.only(left: 5),
          child: CommonAppBar(
            title: LocaleKeys.confirmShipment.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetMenuIcon(),
            leadingWidth: 27,
            centerTitle: true,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      onGetCommonInformation(),
                      onGetOrderList(false),
                    ],
                  ),
                ],
              ),
            )),
            onBottomButton(false)
          ],
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
      currentTab: 2,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColors.appBarColor,
            padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
            child: CommonAppBar(
              title: LocaleKeys.confirmShipment.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 50,
              centerTitle: true,
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollBehavior().copyWith(scrollbars: false),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    onGetCommonInformation(),
                    onGetOrderList(true),
                  ],
                ),
              ]),
            ),
          ),
          onBottomButton(true)
        ],
      ),
    );
  }

  onGetCommonInformation() {
    return Container(
      decoration: BoxDecoration(color: AppColors.whiteColor),
      padding: EdgeInsets.symmetric(
          horizontal: screen.isDesktop ? Get.width / 5 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              Text(LocaleKeys.total.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito)),
              Text("HKD 9000",
                      style: _appTheme.customTextStyle(
                          fontSize: 13,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito))
                  .marginOnly(left: 10)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(LocaleKeys.orderTime.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito)),
              Text("2022-03-28 18:18",
                      style: _appTheme.customTextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito))
                  .marginOnly(left: 10)
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(LocaleKeys.shipmentNo.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito)),
              Text("3",
                      style: _appTheme.customTextStyle(
                          fontSize: 13,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito))
                  .marginOnly(left: 10)
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  onBottomButton(bool isWeb) {
    return Container(
      width: double.infinity,
      color: AppColors.whiteColor,
      child: Column(
        children: [
          onGetConfirmShipmentButton(isWeb),
          onGetUpdateAgainButton(isWeb),
        ],
      ),
    );
  }

  onGetConfirmShipmentButton(bool isWeb) {
    return Container(
      width: Get.width,
      padding: screen.isDesktop
          ? EdgeInsets.only(left: Get.width / 5, right: Get.width / 5, top: 10)
          : EdgeInsets.only(left: 10, right: 10, top: 10),
      child: CommonButton(
        buttonText: LocaleKeys.confirmShipment,
        // width: isWeb == true
        //     ? MediaQuery.of(Get.context!).size.width / 3
        //     : double.infinity,
        backgroundColor: AppColors.appBarColor,
        isBorder: false,
        textColor: AppColors.whiteColor,
        onTap: () {
          screen.isDesktop
              ? Utils.showCommonDialogWeb(
                  title: LocaleKeys.insufficientCredit.tr,
                  positiveText: LocaleKeys.topUpC.tr,
                  negativeText: LocaleKeys.cancel.tr,
                  isNegativeButtonShow: true,
                  onNegativeTap: () {
                    Get.back();
                  },
                  onTap: () {
                    Get.offNamed(RouteName.topUp, arguments: true);
                  })
              : Utils.showCommonDialog(
                  title: LocaleKeys.insufficientCredit.tr,
                  positiveText: LocaleKeys.topUpC.tr,
                  negativeText: LocaleKeys.cancel.tr,
                  isNegativeButtonShow: true,
                  onNegativeTap: () {
                    Get.back();
                  },
                  onTap: () {
                    Get.offNamed(RouteName.topUp, arguments: true);
                  });

          /*   if (formKey.currentState!.validate()) {
            Logger.dev("Done Button Tap");
          } else {
            Logger.dev("Done Validate Failed");
          }*/
        },
      ),
    );
  }

  onGetUpdateAgainButton(bool isWeb) {
    return Container(
      width: Get.width,
      padding: screen.isDesktop
          ? EdgeInsets.symmetric(horizontal: Get.width / 5, vertical: 5)
          : EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: CommonButton(
        buttonText: LocaleKeys.updateAgain.tr,
        backgroundColor: AppColors.whiteColor,
        isBorder: false,
        textColor: AppColors.appBarColor,
        onTap: () {
          if (formKey.currentState!.validate()) {
            Logger.dev("Done Button Tap");
          } else {
            Logger.dev("Done Validate Failed");
          }
        },
      ),
    );
  }

  onGetOrderList(bool isWeb) {
    return AnimationLimiter(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
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
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          index == 0
                              ? LocaleKeys.orderDate
                                  .trParams({'orderDate': '2022-03-28'})
                              : LocaleKeys.orderDate
                                  .trParams({'orderDate': '2022-02-21'}),
                          style: _appTheme.customTextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: index == 0 ? 1 : 2,
                            itemBuilder: (context, index) {
                              return onGetOrderListItem(index, isWeb);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).paddingSymmetric(horizontal: isWeb ? Get.width / 5 : 10),
    );
  }

  onGetOrderListItem(int index, bool isWeb) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                onGetInTransitRecordContent("Hong Kong", "Kelly_Chan"),
                Column(
                  children: [
                    SvgPicture.asset(
                      SVGPath.arrowIcon,
                      color: index == 0
                          ? AppColors.greenColor
                          : AppColors.primaryColor,
                    ),
                    Text(
                      index == 0
                          ? LocaleKeys.completed.tr
                          : LocaleKeys.shipping.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 12,
                          color: index == 0
                              ? AppColors.greenColor
                              : AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ),
                onGetInTransitRecordContent("Central", "John Doe"),
              ],
            ),
          ).paddingAll(10),
          onGetOrderDetails(isWeb),
          onGetOrderClick()
        ],
      ),
    );
  }

  onGetInTransitRecordContent(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: _appTheme.customTextStyle(
              fontSize: 16,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ],
    );
  }

  onGetOrderDetails(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            Text(LocaleKeys.orderNo.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito)),
            Text("#003",
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito))
                .marginOnly(left: 10)
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(LocaleKeys.orderTime.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito)),
            Text("2022-03-28 18:18",
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito))
                .marginOnly(left: 10)
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(LocaleKeys.itemCount.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito)),
            Text("3",
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito))
                .marginOnly(left: 10)
          ],
        ),
        const SizedBox(height: 15),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  onGetOrderClick() {
    return InkWell(
      child: Column(
        children: [
          AppThemeState().commonDivider(),
          Text(
            LocaleKeys.details.tr,
            style: _appTheme.customTextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ).paddingSymmetric(vertical: 12),
        ],
      ),
      onTap: () {
        Get.toNamed(RouteName.confirmShipmentPreview);
      },
    );
  }

  Widget onGetMenuIcon() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: SvgPicture.asset(
          SVGPath.closeIcon,
          color: AppColors.whiteColor,
        ),
      ),
      onTap: () {
        Get.back();
      },
    );
  }
}
