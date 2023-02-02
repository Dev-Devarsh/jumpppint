import 'dart:ui';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/order_details/presentation/controllers/order_detail_controller.dart';
import 'package:jumppoint_app/ui/shipment_tracking/presentation/controllers/shipment_tracking_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

class OrderDetailsView extends GetResponsiveView<OrderDetailsController> {
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
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: Obx(() => CommonAppBar(
              title: '#${controller.trackingNumber.value}',
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 27,
              centerTitle: true,
            )),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(() => controller.isSearchVisible.value
                  ? onGetSearchView(false)
                  : Container()),
              onGetTabBar(false),
              Obx(() => Expanded(
                  flex: 1,
                  child: controller.shipmentDetails.value != null
                      ? onGetTabBarView(false)
                      : controller.showUi.value == false
                          ? Container()
                          : onGetSearch()
                  /*controller.isSearch.value
                      ? controller.shipmentDetails.value != null? onGetTabBarView(false) :  onGetSearch()
                      : onGetSearch()*/
                  )),
              Obx(() => controller.isDetailTab.value
                  ? onGetBottomView(false)
                  : Container()),
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
      currentTab: 4,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Container(
                color: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                child: controller.shipmentDetails.value != null
                    ? CommonAppBar(
                        title:
                            '#${controller.shipmentDetails.value!.trackingNumber!}',
                        elevation: 0.0,
                        isBackButtonVisible: true,
                        leadingWidth: 27,
                        centerTitle: true,
                      )
                    : const CommonAppBar(
                        title: "",
                        elevation: 0.0,
                        isBackButtonVisible: true,
                        leadingWidth: 27,
                        centerTitle: true,
                      ),
              )),
          Obx(() => controller.isSearchVisible.value
              ? onGetSearchView(true)
              : Container()),
          onGetTabBar(true),
          Obx(() => Expanded(
              flex: 1,
              child: controller.shipmentDetails.value != null
                  ? onGetTabBarView(true)
                  : controller.showUi.value == false
                      ? Container()
                      : onGetSearch()
              /* controller.isSearch.value
                  ? controller.shipmentDetails.value != null? onGetTabBarView(true) : Container()
                  : onGetSearch()*/
              )),
          Obx(() => controller.isDetailTab.value
              ? onGetBottomView(true)
              : Container()),
        ],
      ),
    );
  }

  /// ----------------------------------------------------------------
  ///  LAYOUTS
  /// ----------------------------------------------------------------

  onGetSearchView(bool isWeb) {
    return Container(
      color: AppColors.appBarColor,
      padding: isWeb
          ? EdgeInsets.only(
              left: Get.width / 5, right: Get.width / 5, bottom: 10, top: 0)
          : EdgeInsets.only(left: 10, right: 17, bottom: 10, top: 0),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextField(
              controller: controller.editConSearch,
              focusNode: controller.focusSearch,
              enabled: true,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                print("search");
                controller.getOrderDetails(
                    searchText: controller.editConSearch.text.trim());
              },
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.isEmpty) {
                  controller.isSearch.value = true;
                  controller.isSearching.value = false;
                } else {
                  // controller.isSearch.value = false;
                  controller.isSearching.value = true;
                  // controller.getOrderDetails(searchText: controller.editConSearch.text.trim());
                }
              },
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular),
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: LocaleKeys.searchParcelNo.tr,
                contentPadding: const EdgeInsets.only(
                    left: 10, right: 10, top: 0, bottom: 7),
                hintStyle: _appTheme.customTextStyle(
                    fontSize: 14,
                    fontFamilyType: FFT.nunito,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular),
                filled: true,
                fillColor: AppColors.backgroundColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                suffixIcon: Obx(() => controller.isSearching.value
                    ? InkWell(
                        onTap: () {
                          controller.editConSearch.clear();
                          controller.isSearch.value = true;
                          controller.isSearching.value = false;
                          controller.getOrderDetails();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(SVGPath.closeIcon),
                        ),
                      )
                    : const Offstage()),
                suffixIconColor: AppColors.textSecondaryColor,
              ),
            ).marginOnly(right: 16),
          ),
          InkWell(
            child: SvgPicture.asset(
              SVGPath.filterIcon,
              width: 22,
              color: AppColors.whiteColor,
            ).marginOnly(left: 10),
            onTap: () {
              Get.dialog(onGetFilterView());
            },
          )
        ],
      ),
    );
  }

  onGetBottomView(bool isWeb) {
    return Container(
      padding: isWeb
          ? EdgeInsets.only(
              left: Get.width / 5, right: Get.width / 5, bottom: 25, top: 10)
          : EdgeInsets.only(left: 10, right: 10, bottom: 25, top: 10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [AppThemeState().commonBoxShadow()]),
      height: 70,
      child: CommonButton(
        width: Get.width,
        buttonText: LocaleKeys.downloadAllWaybills.tr,
        onTap: () {
          controller.downloadWayBills();
        },
        isBorder: false,
        textColor: AppColors.whiteColor,
      ),
    );
  }

  //tab Bar
  onGetTabBar(bool isWeb) {
    return DefaultTabController(
      length: 2,
      child: Container(
        padding: isWeb
            ? EdgeInsets.only(
                left: Get.width / 5, right: Get.width / 5, bottom: 0, top: 0)
            : null,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: [AppThemeState().commonBoxShadow()]),
        child: TabBar(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          controller: controller.tabController,
          onTap: (tab) {
            if (tab == 0) {
              controller.isDetailTab.value = true;
              controller.isSearchVisible.value = true;
            } else {
              controller.isDetailTab.value = false;
              controller.isSearchVisible.value = false;
            }
          },
          tabs: [
            Tab(
              text: LocaleKeys.itemsTab.tr,
            ),
            Tab(
              text: LocaleKeys.detailsTab.tr,
            ),
          ],
        ),
      ),
    );
  }

  onGetTabBarView(bool isWeb) {
    return TabBarView(controller: controller.tabController, children: [
      onGetItemsTabView(isWeb),
      onGetDetailsTabView(),
    ]).paddingSymmetric(horizontal: isWeb ? Get.width / 5 : 10);
  }

  //Items Tab
  onGetItemsTabView(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        RichText(
          text: TextSpan(
            text: LocaleKeys.parcelCount.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
            children: <TextSpan>[
              TextSpan(
                  text: controller.shipmentDetails.value!.noOfItems.toString(),
                  style: TextStyle(color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Flexible(flex: 1, child: onGetItemsTabListView(isWeb)),
      ],
    );
  }

  onGetItemsTabListView(bool isWeb) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: AnimationLimiter(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.shipmentDetails.value!.items!.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 700),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Container(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 2,
                                child: onGetParcelDetail(isWeb, index),
                              ),
                              Flexible(flex: 1, child: onGetStatus(index)),
                            ],
                          ),
                          AppThemeState().commonDivider(),
                          onGetDetail(index),
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

  onGetParcelDetail(isWeb, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.food.tr,
          // controller.lanCode == "en" ? controller.shipmentDetails.value!.items![index].categoryOption!.descriptionEn! : controller.shipmentDetails.value!.items![index].categoryOption!.descriptionChi!,
          style: _appTheme.customTextStyle(
              fontSize: 16,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        RichText(
          text: TextSpan(
            text: controller.lanCode == "en"
                ? controller.shipmentDetails.value!.items![index]
                    .dimensionOption!.descriptionEn!
                : controller.shipmentDetails.value!.items![index]
                    .dimensionOption!.descriptionChi!,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
            children: <TextSpan>[
              TextSpan(
                  text: controller.lanCode == "en"
                      ? controller.shipmentDetails.value!.items![index]
                          .weightOption!.descriptionEn!
                      : controller.shipmentDetails.value!.items![index]
                          .weightOption!.descriptionChi!,
                  style: TextStyle(color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: LocaleKeys.shipmentNo.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          ' ${controller.shipmentDetails.value!.items![index].itemTrackingNumber}',
                      style: TextStyle(color: AppColors.textPrimaryColor)),
                ],
              ),
            ),
            if (isWeb)
              RichText(
                text: TextSpan(
                  text: LocaleKeys.receivedAt.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' - ${controller.shipmentDetails.value!.deliveryDate}',
                        style: TextStyle(color: AppColors.textPrimaryColor)),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        if (isWeb == false)
          RichText(
            text: TextSpan(
              text: LocaleKeys.receivedAt.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
              children: <TextSpan>[
                TextSpan(
                    text:
                        ' - ${controller.shipmentDetails.value!.deliveryDate}',
                    style: TextStyle(color: AppColors.textPrimaryColor)),
              ],
            ),
          ),
      ],
    ).paddingOnly(top: 14, left: 15, bottom: 10, right: 0);
  }

  onGetStatus(index) {
    return Container(
      color: controller.shipmentDetails.value!.shipmentState! == "completed"
          ? AppColors.greenLightColor
          : AppColors.primaryLightColor,
      margin: EdgeInsets.only(top: 6, right: 7),
      child: Text(
        controller.shipmentDetails.value!.shipmentState!,
        style: _appTheme.customTextStyle(
            fontSize: 12,
            color:
                controller.shipmentDetails.value!.shipmentState! == "completed"
                    ? AppColors.greenColor
                    : AppColors.primaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetDetail(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            // Get.toNamed(RouteName.browseCargo, arguments: 1);
            Get.toNamed(RouteName.browseCargo, arguments: {
              "initialIndex": 1,
              "itemId": controller.shipmentDetails.value?.items?[index].id
            });
          },
          child: Text(
            LocaleKeys.waybillOrder.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
        AppThemeState().commonVerticalDivider(38),
        InkWell(
          onTap: () {
            Get.toNamed(RouteName.browseCargo, arguments: {
              "initialIndex": 0,
              "itemId": controller.shipmentDetails.value?.items?[index].id
            });
          },
          child: Text(
            LocaleKeys.statusOrder.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        )
      ],
    );
  }

  //Details Tab
  onGetDetailsTabView() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(top: 15, bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.whiteColor,
            boxShadow: [
              _appTheme.commonBoxShadow(),
            ]),
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 300),
              childAnimationBuilder: (widget) => FadeInAnimation(
                child: widget,
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.type.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      controller.shipmentDetails.value!.sameDayDelivery == true
                          ? LocaleKeys.expressDelivery.tr
                          : LocaleKeys.standardDelivery.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    )
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.deliveryDate.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      '${Utils.apiOrderDetailsDateFormat(controller.shipmentDetails.value!.deliveryDate!)} (二)',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    )
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.pickupDate.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      '${Utils.apiOrderDetailsDateFormat(controller.shipmentDetails.value!.pickUpDate!)} (一)',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    )
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: AppThemeState().commonDivider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.sender.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Flexible(
                      flex: 1,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text:
                              '${controller.shipmentDetails.value!.originAddress!.contactName!}\n',
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${controller.shipmentDetails.value!.originAddress!.contactPhone!}\n',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondaryColor)),
                            TextSpan(
                                text:
                                    '${controller.shipmentDetails.value!.originAddress!.fullAddress!}',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondaryColor)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.recipient.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Flexible(
                      flex: 1,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.end,
                        text: TextSpan(
                          text:
                              '${controller.shipmentDetails.value!.destinationAddress!.contactName!}\n',
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '${controller.shipmentDetails.value!.destinationAddress!.contactPhone!}\n',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondaryColor)),
                            TextSpan(
                                text: controller.shipmentDetails.value!
                                    .destinationAddress!.fullAddress!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondaryColor)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(top: 8, left: 10, right: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: AppThemeState().commonDivider(),
                ),
                /*  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: LocaleKeys.firstParcels.tr,
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\n3 unit x HKD 64\n',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor,
                                  height: 2)),
                          TextSpan(
                              text: '以體積或重量數值最少三件計算',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor)),
                        ],
                      ),
                    ),
                    Text(
                      '＋ HKD 204',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text:
                            LocaleKeys.remainingX.trParams({'remainingX': '4'}),
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                        children: <TextSpan>[
                          TextSpan(
                              text: '\n65.6kg x HKD 10\n',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor,
                                  height: 2)),
                          TextSpan(
                              text: '以總體積或總重量數值較大者計算',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor)),
                        ],
                      ),
                    ),
                    Text(
                      '＋ HKD 656',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.insurance.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      '＋ HKD 40',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.total.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      'HKD 900',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: AppThemeState().commonDivider(),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.total.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      'HKD ${controller.shipmentDetails.value!.totalCharge!}',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(top: 15, left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.paidByRecipient.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      'HKD ${controller.shipmentDetails.value!.paidByRecipent!}',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(top: 8, left: 10, right: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.paidBySenderCOD.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                    Text(
                      'HKD ${controller.shipmentDetails.value!.paidBySender!}',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ).paddingOnly(top: 8, left: 10, right: 10, bottom: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //filter
  onGetFilterView() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Dialog(
        child: Container(
          height: 555,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onGetFilterReset(),
              AppThemeState().commonDivider(),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      LocaleKeys.shipmentStatus.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ).paddingSymmetric(horizontal: 10),
                    ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(scrollbars: false),
                      child: AnimationLimiter(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ShipmentTrackingController
                                .shipmentStatus.value!.summary!.length,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 700),
                                child: SlideAnimation(
                                  verticalOffset: 50,
                                  child: FadeInAnimation(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : 10),
                                      child: onFilterText(index),
                                    ),
                                  ),
                                ),
                              );
                            }).paddingSymmetric(horizontal: 0),
                      ),
                    ),
                    /*          SizedBox(
                      height: 7,
                    ),
                    onGetCreatedText(),
                    SizedBox(
                      height: 10,
                    ),
                    onGetCollectedText(),
                    SizedBox(
                      height: 10,
                    ),
                    onGetShippingText(),
                    SizedBox(
                      height: 10,
                    ),
                    onGetCompletedText(),
                    */
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      LocaleKeys.orderDateFilter.tr,
                      style: _appTheme.customTextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ).paddingSymmetric(horizontal: 10),
                    SizedBox(
                      height: 10,
                    ),
                    onGetFromTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    onGetToTextField(),
                    SizedBox(
                      height: 21,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Center(
                  child: Text(
                    LocaleKeys.confirm.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ).paddingSymmetric(vertical: 10),
                ),
              ),
              SizedBox(
                height: 7,
              )
            ],
          ),
        ),
      ),
    );
  }

  onFilterText(int index) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              SVGPath.rightIcon,
              width: 12,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            ShipmentTrackingController
                .shipmentStatus.value!.summary![index].shipmentState!,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetFilterReset() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: SvgPicture.asset(
            SVGPath.closeIcon,
            width: 12,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Get.back();
          },
        ),
        Text(
          LocaleKeys.filter.tr,
          style: _appTheme.customTextStyle(
              fontSize: 16,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        InkWell(
          onTap: () {},
          child: Text(
            LocaleKeys.reset.tr,
            style: _appTheme.customTextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 15);
  }

  onGetCreatedText() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              SVGPath.rightIcon,
              width: 12,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            LocaleKeys.created.tr,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetCollectedText() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              SVGPath.rightIcon,
              width: 12,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            LocaleKeys.collected.tr,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetShippingText() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              SVGPath.rightIcon,
              width: 12,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            LocaleKeys.shipping.tr,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetCompletedText() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              SVGPath.rightIcon,
              width: 12,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            LocaleKeys.completed.tr,
            style: _appTheme.customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  onGetFromTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownFormField<Map<String, dynamic>>(
        onEmptyActionPressed: () async {},
        emptyActionText: "",
        emptyText: "No matching found!",
        controller: controller.fromController.value,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
          errorMaxLines: 3,
          errorStyle: AppThemeState().customTextStyle(
              fontSize: 12,
              fontFamilyType: FFT.nunito,
              color: AppColors.primaryColor,
              fontWeightType: FWT.regular),
          labelText: LocaleKeys.from.tr,
          labelStyle: AppThemeState().customTextStyle(
              fontSize: 14,
              fontFamilyType: FFT.nunito,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 17),
            child: SvgPicture.asset(
              SVGPath.dateIcon,
              width: 16,
              color: AppColors.textSecondaryColor,
            ),
          ),
          filled: true,
          fillColor: AppColors.backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColors.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
        ),
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          print("${str['name']}");
          if (str != null) {
            controller.isFromFilled.value = true;
          }
        },
        validator: (dynamic str) {
          return 'Relationship is required';
        },
        displayItemFn: (dynamic item) => Row(
          children: [
            Text(
              item != null ? item['name'] : '',
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        findFn: (dynamic str) async => controller.roles,
        filterFn: (dynamic item, str) =>
            item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, position, focused,
                dynamic lastSelectedItem, onTap) =>
            ListTile(
          title: Text(
            item['name'],
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          subtitle: Text(
            'Confirm order before 8pm of the previous day ',
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          tileColor: focused
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.whiteColor,
          onTap: onTap,
        ),
      ),
    );
  }

  onGetToTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownFormField<Map<String, dynamic>>(
        controller: controller.toController.value,
        onEmptyActionPressed: () async {},
        emptyActionText: "",
        emptyText: "No matching found!",
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding:
              const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
          errorMaxLines: 3,
          errorStyle: AppThemeState().customTextStyle(
              fontSize: 12,
              fontFamilyType: FFT.nunito,
              color: AppColors.primaryColor,
              fontWeightType: FWT.regular),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 17),
            child: SvgPicture.asset(
              SVGPath.dateIcon,
              width: 16,
              color: AppColors.textSecondaryColor,
            ),
          ),
          labelText: LocaleKeys.to.tr,
          labelStyle: AppThemeState().customTextStyle(
              fontSize: 14,
              fontFamilyType: FFT.nunito,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular),
          filled: true,
          fillColor: AppColors.backgroundColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColors.borderColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
        ),
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          if (str != null) {
            controller.isToSelected.value = true;
          }
        },
        validator: (dynamic str) {},
        displayItemFn: (dynamic item) => Row(
          children: [
            Text(
              item != null ? item['name'] : '',
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        findFn: (dynamic str) async => controller.roles,
        filterFn: (dynamic item, str) {
          return item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0;
        },
        dropdownItemFn:
            (dynamic item, position, focused, dynamic lastSelectedItem, onTap) {
          return ListTile(
            title: Text(
              item['name'],
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            subtitle: Text(
              'Confirm order before 8pm of the previous day ',
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            tileColor: focused
                ? AppColors.primaryColor.withOpacity(0.1)
                : AppColors.whiteColor,
            onTap: onTap,
          );
        },
      ),
    );
  }

  // no record
  onGetSearch() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      child: Text(
        LocaleKeys.noRecord.tr,
        style: _appTheme.customTextStyle(
            fontSize: 16,
            color: AppColors.secondaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }
}
