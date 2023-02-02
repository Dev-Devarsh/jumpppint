import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/home/presentation/controllers/home_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/asset_images.dart';
import '../../../../utills/colors.dart';
import '../../../../utills/enum/font_type.dart';
import '../../../../utills/generated/locales.g.dart';
import '../../../common/custom_drawer.dart';

class HomeView extends GetResponsiveView<HomeController> {
  final AppThemeState _appTheme = AppThemeState();
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
        drawer: Drawer(
          child: CommonDrawer(currentIndex: RxInt(0), onLogoutClick: () {
            controller.logout();
          },),
        ),
        backgroundColor: AppColors.statusBarColor,
        body: SafeArea(
          child: Obx(() => Container(
                color: AppColors.backgroundColor,
                padding: !kIsWeb
                    ? Platform.isIOS
                        ? const EdgeInsets.only(bottom: 30)
                        : EdgeInsets.zero
                    : EdgeInsets.zero,
                child: Center(
                  child: Stack(
                    children: [
                      onGetBackgroundLayout(false),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: (!kIsWeb && Platform.isIOS) ? 30 : 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                onGetMenuIcon(),
                                onGetNotificationIcon(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                onGetUserDetails(),
                                onGetTopUpButton()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: onGetStickyWayBills(),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior:
                                  ScrollBehavior().copyWith(scrollbars: false),
                              child: SingleChildScrollView(
                                child: Obx(() => AnimationLimiter(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: AnimationConfiguration
                                            .toStaggeredList(
                                          duration:
                                              const Duration(milliseconds: 700),
                                          childAnimationBuilder: (widget) =>
                                              SlideAnimation(
                                            verticalOffset: 100,
                                            child: FadeInAnimation(
                                              child: widget,
                                            ),
                                          ),
                                          children: [
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: onGetCreateStatement(),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: onGetShipmentStatus(),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: onGetShipmentRecord (false),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            //onGetImportantNoticeLayout(),
                                            controller.inAppNoticeList.isNotEmpty && controller.inAppNoticeList.length > controller.isNotice.value
                                                ? onGetImportantNoticeLayout()
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
      currentTab: 0,
      body: Stack(
        children: [
          onGetBackgroundLayout(true),
          AnimationLimiter(
            child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  duration: const Duration(milliseconds: 700),
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [onGetUserDetails(), onGetTopUpButton()],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: onGetCreateStatement(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior().copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 7,
                                  child: onGetInTransitRecord(),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Flexible(
                                  flex: 4,
                                  child: onGetShipmentRecordWeb(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ))),
          ),
        ],
      ),
    );
  }

  /// ----------------------------------------------------------------
  ///  MOBILE LAYOUT
  /// ----------------------------------------------------------------

  Widget onGetMenuIcon() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 15),
        child: SvgPicture.asset(
          SVGPath.drawerIcon,
          color: AppColors.whiteColor,
        ),
      ),
      onTap: () {
        scaffoldKey.currentState!.openDrawer();
      },
    );
  }

  Widget onGetNotificationIcon() {
    return InkWell(
      child: Badge(
        animationType: BadgeAnimationType.slide,
        badgeColor: AppColors.whiteColor,
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
        position: BadgePosition.topStart(start: -5),
        badgeContent: Text(
          '3',
          style: AppThemeState().customTextStyle(
              fontSize: 9,
              color: AppColors.primaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        child: SvgPicture.asset(
          SVGPath.notificationIcon,
          width: 22,
          color: AppColors.whiteColor,
        ),
      ),
      onTap: () {
        Get.toNamed(RouteName.notificationCenter);
      },
    );
  }

  onGetTopUpButton() {
    return CommonButton(
        textColor: AppColors.whiteColor,
        buttonText: LocaleKeys.topUpC.tr,
        isBorder: true,
        borderColor: AppColors.whiteColor,
        onTap: () {
          Get.toNamed(RouteName.topUp, arguments: false);
        });
  }

  onGetUserDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.userData.value?.name ?? "",
          style: AppThemeState().customTextStyle(
              fontSize: 20,
              color: AppColors.whiteColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.credits.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontWeightType: FWT.light,
                  fontFamilyType: FFT.nunito),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              "HKD ${controller.userData.value?.merchant.accountBalance ?? ""}",
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
      ],
    );
  }

  onGetBackgroundLayout(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 185,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xffeb5236), Color(0xaaeb4136)],
            ),
          ),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        ),
        const Expanded(
          flex: 9,
          child: Offstage(),
        ),
      ],
    );
  }

  onGetStickyWayBills() {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteName.applyWayBills,
        );
      },
      child: Container(
        width: Get.width,
        height: 61,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.stickyColor,
            boxShadow: [
              _appTheme.commonBoxShadow(),
            ]),
        child: Row(
          children: [
            Image.asset(
              PNGPath.dummyWayBills,
              height: 40,
              width: 56,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 1,
              child: Text(
                LocaleKeys.applyForWayBills.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              SVGPath.viewMoreIcon,
              width: 22,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  onGetCreateStatement() {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouteName.coTypePage,
        );
      },
      child: Container(
        width: Get.width,
        height: 61,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.whiteColor,
            boxShadow: [
              _appTheme.commonBoxShadow(),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                LocaleKeys.createShipment.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SvgPicture.asset(
              SVGPath.viewMoreIcon,
              width: 22,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  onGetShipmentStatus() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: onGetShipmentStatusList(),
    );
  }

  onGetEmptyShipmentStatusLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.createShipment.tr,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            LocaleKeys.noShipmentYet.tr,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetShipmentStatusList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              LocaleKeys.shipmentStatus.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AppThemeState().commonDivider(),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Obx(()=>Text(
              "${LocaleKeys.totalShipments.tr} ${controller.totalCount.value}",
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            )) ,
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(()=>Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.summary.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 3 / 3.2),
                itemBuilder: (context, index) {
                  return onGetStatusCard(
                      index == 0 ? true : false,
                      index == 1 ? true : false,
                      controller.summary[index]?.count ?? 0,
                      controller.summary[index]?.shipmentState ?? "");
                }),
          )),
          Align(
            alignment: AlignmentDirectional.center,
            child: InkWell(
              onTap: () {
                Get.toNamed(RouteName.shipmentTrackingPage);
              },
              child: Text(
                LocaleKeys.viewAll.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.primaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  onGetStatusCard(bool isSelected, bool isCompleted, int count, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.05)
            : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: _appTheme.customTextStyle(
                fontSize: 32,
                color:
                    isCompleted ? AppColors.greenColor : AppColors.primaryColor,
                fontWeightType: FWT.semiBold,
                fontFamilyType: FFT.nunito),
          ),
          Text(
            label,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetShipmentRecord(bool fromWeb) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocaleKeys.shipmentRecords.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteName.shipmentTrackingPage);
                  },
                  child: Text(
                    LocaleKeys.viewAll.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() =>  ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.shipmentRecordListData.length,
              itemBuilder: (context, index) {
                return onGetRecordItem(index);
              })
          )
        ],
      ),
    );
  }

  onGetRecordItem(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    onGetRecordContent(LocaleKeys.wayBillNumber.tr,
                        "#${controller.shipmentRecordListData[index]?.trackingNumber}"),
                    const SizedBox(
                      height: 5,
                    ),
                    onGetRecordContent(LocaleKeys.noOfParcel.tr,
                        "${controller.shipmentRecordListData[index]?.noOfItems}"),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    onGetRecordContent(LocaleKeys.address.tr,
                        "${controller.shipmentRecordListData[index]?.originAddress?.fullAddress}"
                            " TO ${controller.shipmentRecordListData[index]?.destinationAddress?.fullAddress}"),
                    const SizedBox(
                      height: 5,
                    ),
                    onGetRecordContent(
                        LocaleKeys.created.tr, Utils.apiDateFormet(controller.shipmentRecordListData[index]?.createdAt??"")),
                  ],
                ),
              ),
            ],
          ),
        ),
        index < controller.shipmentRecordListData.length - 1
            ? const SizedBox(
                height: 12,
              )
            : const Offstage(),
        index < controller.shipmentRecordListData.length - 1
            ? AppThemeState().commonDivider()
            : const Offstage(),
        index < controller.shipmentRecordListData.length - 1
            ? const SizedBox(
                height: 15,
              )
            : const Offstage(),
      ],
    );
  }

  onGetRecordContent(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        const SizedBox(
          width: 12,
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

  onGetImportantNoticeLayout() {
    return Obx(() => Container(
      width: Get.width,
      color: AppColors.stickyColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  LocaleKeys.importantNotice.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.primaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  controller.isNotice.value++;
                },
                child: SvgPicture.asset(
                  SVGPath.closeIcon,
                  width: 16,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            controller.inAppNoticeList[controller.isNotice.value].message??"",
            style: _appTheme.customTextStyle(
                fontSize: 13,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.light,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    ));
  }

  /// ----------------------------------------------------------------
  ///  WEB LAYOUT
  /// ----------------------------------------------------------------

  onGetShipmentRecordWeb() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: Get.width,
      height: Get.height/1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocaleKeys.shipmentRecords.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteName.shipmentTrackingPage);
                  },
                  child: Text(
                    LocaleKeys.viewAll.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
         Expanded(child:  Obx(() =>  ListView.builder(
             physics: const BouncingScrollPhysics(),
             shrinkWrap: true,
             itemCount: controller.shipmentRecordListData.length,
             itemBuilder: (context, index) {
               return onGetRecordItem(index);
             }))
          )
        ],
      ),
    );
  }

  onGetInTransitRecord() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      width: Get.width,
      height: Get.height/1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      LocaleKeys.orderInTransit.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteName.shipmentTrackingPage);
                    },
                    child: Text(
                      LocaleKeys.viewAll.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.shipmentRecordListData.length,
                itemBuilder: (context, index) {
                  return onGetInTransitRecordItem(index);
                }))
          ],
        ),
      ),
    );
  }

  onGetInTransitRecordItem(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onGetInTransitRecordContent(
                    LocaleKeys.wayBillNumber.tr, "JP003003003"),
                const SizedBox(
                  width: 5,
                ),
                AppThemeState().commonVerticalDivider(40),
                const SizedBox(
                  width: 5,
                ),
                onGetInTransitRecordContent("Kwai Tsing", "Kelly_Chan"),
                const SizedBox(
                  width: 14,
                ),
                SvgPicture.asset(
                  SVGPath.intransitArrowIcon,
                  width: 35,
                  color: AppColors.textPrimaryColor,
                ),
                const SizedBox(
                  width: 14,
                ),
                onGetInTransitRecordContent("Yuen Long", "John Doe"),
                const SizedBox(
                  width: 5,
                ),
                AppThemeState().commonVerticalDivider(40),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    onGetRecordContent(
                        LocaleKeys.created.tr, "2022-03-28 18:18"),
                    const SizedBox(
                      height: 5,
                    ),
                    onGetRecordContent(LocaleKeys.totalNoOfGoods.tr, "3"),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  onGetInTransitRecordContent(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: _appTheme.customTextStyle(
              fontSize: 12,
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
}
