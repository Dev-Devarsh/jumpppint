import 'dart:ui';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/custom_drawer.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/shipment_tracking/model/area_rank_response.dart';
import 'package:jumppoint_app/ui/shipment_tracking/presentation/controllers/shipment_tracking_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_textformfield.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/constants.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../routes.dart';

class ShipmentTrackingView
    extends GetResponsiveView<ShipmentTrackingController> {
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
        child: CommonAppBar(
          title: LocaleKeys.shipmentTracking.tr,
          elevation: 0.0,
          isBackButtonVisible: false,
          leadingWidth: 50,
          leading: onGetBackIcon(),
          centerTitle: true,
        ),
      ),
      drawer: Drawer(
        child: CommonDrawer(currentIndex: RxInt(4), onLogoutClick: () {
          controller.logout();
        },),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              onGetSearchView(false),
              Obx(() => Expanded(
                  flex: 1,
                  child: onGetOrderList(false)/*controller.isSearch.value
                      ? onGetOrderList(false)
                      : onGetSearch()*/)),
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
          CommonAppBar(
            title: LocaleKeys.shipmentTracking.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leadingWidth: 27,
            centerTitle: true,
          ),
          onGetSearchView(true),
          Obx(() => Expanded(
              flex: 1,
              child: onGetOrderList(true)/*controller.isSearch.value
                  ? onGetOrderList(true)
                  : onGetSearch()*/))
        ],
      ),
    );
  }


  onGetBackIcon() {
      return InkWell(
        onTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
          child: SvgPicture.asset(
            SVGPath.drawerIcon,
            color: AppColors.whiteColor,
          ),
        ),
      );
    }

  Widget onGetMenuIcon() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15,top: 15,bottom: 15),
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

  onGetSearchView(bool isWeb) {
    return Container(
      color: AppColors.appBarColor,
      padding: isWeb
          ? EdgeInsets.only(left: Get.width/5, right: Get.width/5, bottom: 10, top: 0)
          : EdgeInsets.only(left: 10, right: 17, bottom: 10, top: 0),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.editConSearch,
              focusNode: controller.focusSearch,
              enabled: true,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
               controller.getShipmentRecordList(isFilter: true);
                /* if (value.isEmpty) {
                  controller.isSearch.value = true;
                } else {
                  controller.isSearch.value = false;
                }*/
              },
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  fontFamilyType: FFT.nunito,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular),
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                hintText: LocaleKeys.searchShipment.tr,
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
                suffixIcon: Obx(() => !controller.isSearch.value
                    ? InkWell(
                        onTap: () {
                          controller.editConSearch.clear();
                          controller.isSearch.value = true;
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

  onGetOrderList(bool isWeb) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: AnimationLimiter(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:  controller.shipmentRecordListData.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                  duration: const Duration(milliseconds: 700),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Container(
                      padding: EdgeInsets.only(top: getPadding(index)),
                      child: Column(
                        children: [
                          if(index == 0 ) ...[
                            Text(controller.shipmentRecordListData[index]!.createdAtOld!,
                              style: _appTheme.customTextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            ),
                          ] else if(controller.shipmentRecordListData[index]?.createdAtOld != controller.shipmentRecordListData[index-1]?.createdAtOld ) ...[
                            Text(controller.shipmentRecordListData[index]!.createdAtOld!,
                              style: _appTheme.customTextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondaryColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            ),
                          ],
                          onGetOrderListItem(index, isWeb)
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     physics: NeverScrollableScrollPhysics(),
                          //     itemCount: index == 0 ? 1 : 2,
                          //     itemBuilder: (context, index) {
                          //       return onGetOrderListItem(index, isWeb);
                          //     })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).paddingSymmetric(horizontal: isWeb ? Get.width/5 : 10),
      ),
    );
  }

  double getPadding(int index){
    if(index == 0){
      return 20;
    }else if(controller.shipmentRecordListData[index]?.createdAtOld != controller.shipmentRecordListData[index-1]?.createdAtOld){
      return 20;
    }
   return 0;
  }


  onGetOrderList1(bool isWeb) {
    return ScrollConfiguration(
      behavior: ScrollBehavior().copyWith(scrollbars: false),
      child: AnimationLimiter(
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
            }).paddingSymmetric(horizontal: isWeb ? Get.width/5 : 10),
      ),
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
                onGetInTransitRecordContent(controller.shipmentRecordListData[index]!.originAddress!.fullAddress!, controller.shipmentRecordListData[index]!.originAddress!.contactName!),
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        SVGPath.arrowIcon,
                        color:  controller.shipmentRecordListData[index]!.shipmentState =="completed"
                            ? AppColors.greenColor
                            : AppColors.primaryColor,
                      ),
                      Text(
                        controller.shipmentRecordListData[index]!.shipmentState!,
                        style: _appTheme.customTextStyle(
                            fontSize: 12,
                            color: controller.shipmentRecordListData[index]!.shipmentState =="completed"
                                ? AppColors.greenColor
                                : AppColors.primaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                    ],
                  ),
                ),
                onGetInTransitRecordContent(controller.shipmentRecordListData[index]!.destinationAddress!.fullAddress!, controller.shipmentRecordListData[index]!.destinationAddress!.contactName!),
              ],
            ),
          ).paddingAll(10),
          onGetOrderDetails(isWeb,index),
          onGetOrderClick(index)
        ],
      ),
    );
  }

  onGetInTransitRecordContent(String title, String value) {
    return Expanded(
      child: Column(
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
      ),
    );
  }

  onGetOrderDetails(bool isWeb,int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: RichText(
                text: TextSpan(
                  text: LocaleKeys.orderNo.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                  children: <TextSpan>[
                    TextSpan(
                        text: controller.shipmentRecordListData[index]!.trackingNumber,
                        style: TextStyle(color: AppColors.textPrimaryColor)),
                  ],
                ),
              ),
            ),
            if (isWeb)
              Expanded(
                flex: 1,
                child: RichText(
                  text: TextSpan(
                    text: LocaleKeys.orderTime.tr,
                    style: _appTheme.customTextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                    children: <TextSpan>[
                      TextSpan(
                          text: Utils.apiDateFormet(controller.shipmentRecordListData[index]!.createdAt!),
                          style: TextStyle(color: AppColors.textPrimaryColor)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        if (isWeb == false)
          RichText(
            text: TextSpan(
              text: LocaleKeys.orderTime.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
              children: <TextSpan>[
                TextSpan(
                    text: Utils.apiDateFormet(controller.shipmentRecordListData[index]!.createdAt!),
                    style: TextStyle(color: AppColors.textPrimaryColor)),
              ],
            ),
          ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            text: LocaleKeys.itemCount.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
            children: <TextSpan>[
              TextSpan(
                  text: controller.shipmentRecordListData[index]!.noOfItems!.toString(),
                  style: TextStyle(color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
        SizedBox(height: 15),
      ],
    ).paddingSymmetric(horizontal: 10);
  }

  onGetOrderClick(int index) {
    return Column(
      children: [
        AppThemeState().commonDivider(),
        InkWell(
          onTap: () {
            StringConstants.trackingId =  controller.shipmentRecordListData[index]!.id!.toString();
             Get.toNamed(RouteName.orderDetailPage,arguments: {"trackingNumber":controller.shipmentRecordListData[index]?.trackingNumber});
          },
          child: Text(
            LocaleKeys.details.tr,
            style: _appTheme.customTextStyle(
                fontSize: 16,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ).paddingSymmetric(vertical: 12),
        ),
      ],
    );
  }

  //searching No Record
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
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
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
                      const SizedBox(
                        height: 7,
                      ),
                      ScrollConfiguration(
                        behavior: ScrollBehavior().copyWith(scrollbars: false),
                        child: AnimationLimiter(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ShipmentTrackingController.shipmentStatus.value!.summary!.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 700),
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: Container(
                                        padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
                                        child: onFilterText(index),
                                      ),
                                    ),
                                  ),
                                );
                              }).paddingSymmetric(horizontal: 0),
                        ),
                      ),
                     /* onGetCreatedText(),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetCollectedText(),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetShippingText(),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetCompletedText(),
                      const SizedBox(
                        height: 25,
                      ),*/
                      const SizedBox(
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
                      const SizedBox(
                        height: 10,
                      ),
                      onGetFromTextFormField(),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetToTextFormField(),
                      const SizedBox(
                        height: 21,
                      ),
                      Text(
                        LocaleKeys.sendingRegion.tr,
                        style: _appTheme.customTextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ).paddingSymmetric(horizontal: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetRegionTextFormField(0),
                      const  SizedBox(
                        height: 10,
                      ),
                      onGetAreaTextFormField(0),
                      const SizedBox(
                        height: 21,
                      ),
                      Text(
                        LocaleKeys.receivingRegion.tr,
                        style: _appTheme.customTextStyle(
                            fontSize: 12,
                            color: AppColors.secondaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ).paddingSymmetric(horizontal: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetRegionTextFormField(1),
                      const SizedBox(
                        height: 10,
                      ),
                      onGetAreaTextFormField(1),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  controller.getShipmentRecordList(isFilter: true);
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
              const SizedBox(
                height: 7,
              )
            ],
          ),
        ),
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

  onFilterText(int index) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: AppColors.borderColor),
      ),
      child: InkWell(
        onTap: (){
          ShipmentTrackingController.shipmentStatus.value!.summary![index].isCheck?.value = !(ShipmentTrackingController.shipmentStatus.value!.summary![index].isCheck?.value??true);
        },
        child: Row(
          children: [
            Obx(() => ShipmentTrackingController.shipmentStatus.value!.summary![index].isCheck?.value == true ? SvgPicture.asset(
              SVGPath.rightIcon,
              width: 12,
              color: AppColors.primaryColor,
            ):Container()),
            const SizedBox(
              width: 10,
            ),
            Text(
              ShipmentTrackingController.shipmentStatus.value!.summary![index].shipmentState!,
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
      ),
    );
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

  /*onGetFromTextField() {
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
                alignLabelWithHint:true,
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
            dropdownItemFn: (dynamic item, position, focused,
                dynamic lastSelectedItem, onTap) {
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
  }*/

  onGetFromTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
          child: CustomTextFormField(
            prefixWidget: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 17),
              child: SvgPicture.asset(
                SVGPath.dateIcon,
                width: 16,
                color: AppColors.textSecondaryColor,
              ),
            ),
            backgroundColor: AppColors.whiteColor,
            editController: controller.editConFrom,
            focusNode: controller.focusFrom,
            isEnabled: false,
            labelText: LocaleKeys.from.tr,
            textInputType: TextInputType.none,
            isAlignLabelWithHint: true,
            onChange: (value) {
              // controller.fromStr.value = value!;
            },
            onValidate: (value) {
              return Validator.emptyValidator(value);
            },
          ),
          onTap: () async {
            final DateTime? selected = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(3000),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.appBarColor,
                      onPrimary: AppColors.whiteColor,
                      onSurface: AppColors.appBarColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: AppColors.appBarColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (selected != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(selected);
              controller.editConFrom.text = formattedDate;
              controller.selectedFromDate.value = selected;
              controller.editConTo.text = "";
              controller.selectedToDate.value = DateTime(1900);
            } else {
              print("Date is not selected");
            }
          }),
    );
  }

  onGetToTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
          child: CustomTextFormField(
            prefixWidget: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 17),
              child: SvgPicture.asset(
                SVGPath.dateIcon,
                width: 16,
                color: AppColors.textSecondaryColor,
              ),
            ),
            backgroundColor: AppColors.whiteColor,
            editController: controller.editConTo,
            focusNode: controller.focusTo,
            isEnabled: false,
            labelText: LocaleKeys.to.tr,
            textInputType: TextInputType.none,
            isAlignLabelWithHint: true,
            onChange: (value) {
              // controller.fromStr.value = value!;
            },
            onValidate: (value) {
              return Validator.emptyValidator(value);
            },
          ),
          onTap: () async {
            final DateTime? selected = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: controller.selectedFromDate.value,
              lastDate: DateTime(3000),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.appBarColor,
                      onPrimary: AppColors.whiteColor,
                      onSurface: AppColors.appBarColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        primary: AppColors.appBarColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (selected != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(selected);
              controller.editConTo.text = formattedDate;
              controller.selectedToDate.value = selected;
            } else {
              print("Date is not selected");
            }
          }),
    );
  }

  onGetRegionTextFormField(int type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownFormField<AreaRanks>(
        onEmptyActionPressed: () async {},
        emptyActionText: "",
        emptyText: "No Region found!",
        controller: controller.regionController.value,
        decoration:
        AppThemeState().commonDropDownDecoration(LocaleKeys.region.tr),
        onSaved: (dynamic str) {},
        validator: (dynamic str) {
          return 'Relationship is required';
        },
        onChanged: (dynamic value){
          if(type == 0){
            controller.sendingRegion.value = value;
          }else{
            controller.receivingRegion.value = value;
          }
        },
        displayItemFn: (dynamic item) => Row(
          children: [
            // item != null ? item['name'] : '',
            Text(
              item != null ? item.district.en : '',
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        findFn: (dynamic str) async => controller.areaRanksList,
        filterFn: (dynamic item, str) =>
        item.district.en.toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, position, focused,
                dynamic lastSelectedItem, onTap) =>
            ListTile(
          title: Text(
            item.district.en,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          /*subtitle: Text(
            '13-15 Wai Fung Street, Ap Lei Chau',
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),*/
          tileColor: focused
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.whiteColor,
          onTap: onTap,
        ),
      ),
    );
  }

  onGetAreaTextFormField(int type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownFormField<Areas>(
        onEmptyActionPressed: () async {},
        emptyActionText: "",
        emptyText: "No Area found!",
        controller: controller.areaController.value,
        decoration: AppThemeState().commonDropDownDecoration(LocaleKeys.area.tr),
        onSaved: (dynamic str) {},
        onChanged: (dynamic str) {
          if (str != null) {
            if (type == 0) {
              controller.sendingAreas.value = str;
            }else{
              controller.receivingAreas.value = str;
            }
          }
        },
        validator: (dynamic str) {
          return 'Relationship is required';
        },
        displayItemFn: (dynamic item) => Row(
          children: [
            Text(
              item != null ? item.en : '',
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
          ],
        ),
        findFn: (dynamic str) async => type == 0 ? controller.sendingRegion.value!.areas : controller.receivingRegion.value!.areas,
        filterFn: (dynamic item, str) =>
            item.en.toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, position, focused,
                dynamic lastSelectedItem, onTap) =>
            ListTile(
          title: Text(
            item.en,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          /*subtitle: Text(
            '13-15 Wai Fung Street, Ap Lei Chau',
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),*/
          tileColor: focused
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.whiteColor,
          onTap: onTap,
        ),
      ),
    );
  }
}
