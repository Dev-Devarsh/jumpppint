import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/create_order/type/presentation/controllers/type_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../../routes.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/enum/font_type.dart';

class ShipmentPreviewView extends GetResponsiveView<TypeController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget? builder() {
    if (screen.isPhone) {
      print("currentType==>> ${controller.currentType.value}");
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
          title: LocaleKeys.shipmentPreview.tr,
          elevation: 0.0,
          isBackButtonVisible: false,
          leading: onGetBackIcon(),
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      onGetShipmentQuotationView(),
                      onGetShipmentPreviewView(false),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                ),
              ),
                  )),
              onGetBottomBar()
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
      currentTab: 1,
      body: Column(
        children: [
          Container(
              color: AppColors.primaryColor,
              padding:  EdgeInsets.symmetric(horizontal: Get.width/5),
              child: CommonAppBar(
                title: LocaleKeys.shipmentPreview.tr,
                elevation: 0.0,
                isBackButtonVisible: false,
                leadingWidth: 50,
                centerTitle: true,
              )),
          Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(scrollbars: false),
                child: ListView(
                  children: [
                    onGetShipmentQuotationView(),
                    onGetShipmentPreviewView(true),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              )),
          onGetBottomBar()
        ],
      ),
    );
  }

  //bottom bar
  onGetBottomBar() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          AppThemeState().commonBoxShadow(),
        ],
      ),
      padding: screen.isDesktop
          ? EdgeInsets.symmetric(vertical: 10, horizontal: Get.width/5)
          : const EdgeInsets.all(10),
      child: Column(
        children: [
          CommonButton(
            buttonText: LocaleKeys.confirmShipment.tr,
            width: Get.width,
            isBorder: false,
            onTap: () {
              if(double.parse(controller.totalPrice) <= double.parse(controller.userData.value?.merchant.accountBalance ?? "")){
                controller.doCreateShipment();
                Get.offNamed(RouteName.shipmentDone);
              }else{
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
                    Get.offNamed(RouteName.topUp,arguments: true);
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
                    Get.offNamed(RouteName.topUp,arguments: true);
                  });}
            },
            textColor: AppColors.whiteColor,
          ),
          const SizedBox(
            height: 10,
          ),
          CommonButton(
            buttonText: LocaleKeys.cancel.tr,
            width: Get.width,
            backgroundColor: AppColors.whiteColor,
            isBorder: false,
            textColor: AppColors.stateDisableColor,
            onTap: () {
              Get.offNamed(RouteName.homePage);
            },
          ),
        ],
      ),
    );
  }

  onGetShipmentPreviewView(isWeb) {
    print("currentType==>> ${controller.currentType.value}");
    return Container(
      width: Get.width,
      margin: isWeb
          ? EdgeInsets.only(top: 15, left: Get.width/5, right: Get.width/5)
          : const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [
            _appTheme.commonBoxShadow(),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.shipmentType.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
              Obx(() =>  Text(
                // LocaleKeys.expressDelivery.tr,
                controller.currentType.value == 1 ? "Standard Delivery" : "Express Delivery",
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ))
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
                controller.currentType.value == 2 ? controller.selectSenderDate.value : '2022-03-29 (二)',
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
                controller.currentType.value == 2 ? controller.selectRecipientDate.value : '2022-03-28 (一)',
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              )
            ],
          ).paddingOnly(top: 15, left: 10, right: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
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
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: (controller.currentType.value != 0 || controller.currentTypeSender.value == 1) ?'${controller.senderAddressData?.contactName}\n':'${controller.senderName}\n',
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                    children: <TextSpan>[
                      TextSpan(
                          text: (controller.currentType.value != 0 || controller.currentTypeSender.value == 1) ? '+${controller.senderAddressData?.regionCode} ${controller.senderAddressData?.contactPhone}\n' :'+${controller.senderNumber} ${controller.senderMobileNumber}\n',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondaryColor)),
                      TextSpan(
                          text: (controller.currentType.value != 0 || controller.currentTypeSender.value == 1) ? '${controller.recipientAddressData?.room} ${controller.recipientAddressData?.floor} ${controller.senderAddressData?.address}' :'${controller.senderData?.districtInfo?.area?.en} ${controller.senderData?.districtInfo?.district?.en}\n${controller.senderData?.address}',
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
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: (controller.currentType.value != 0 || controller.currentTypeSender.value == 1) ?'${controller.recipientAddressData?.contactName}\n':'${controller.recipientName}\n',
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                    children: <TextSpan>[
                      TextSpan(
                          text: (controller.currentType.value != 0 || controller.currentTypeSender.value == 1) ? '+${controller.recipientAddressData?.regionCode} ${controller.recipientAddressData?.contactPhone}\n' :'+${controller.recipientNumber} ${controller.recipientMobileNumber}\n',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondaryColor)),
                      TextSpan(
                          text: (controller.currentType.value != 0 || controller.currentTypeSender.value == 1) ? '${controller.recipientAddressData?.room} ${controller.recipientAddressData?.floor} ${controller.recipientAddressData?.address}' :'${controller.recipientData?.districtInfo?.area?.en} ${controller.recipientData?.districtInfo?.district?.en}\n${controller.recipientData?.address}',
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
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: AppThemeState().commonDivider(),
          ),
          /*Row(
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
                        text: '以體積或重量數值最少三件計算\n',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textSecondaryColor)),
                    TextSpan(
                        text: '(收費以入倉重量體積為準)',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.primaryColor)),
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
                  text: LocaleKeys.remainingX.trParams({'remainingX': '4'}),
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
                        text: '以總體積或總重量數值較大者計算\n',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textSecondaryColor)),
                    TextSpan(
                        text: '(收費以入倉重量體積為準)',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.primaryColor)),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: AppThemeState().commonDivider(),
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.currentShipmentCost.value == 0 ? LocaleKeys.toBePaidBySender.tr : LocaleKeys.toBePaidByReceiver.tr,
                // LocaleKeys.paidByRecipient.tr,
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
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ],
          ).paddingOnly(left: 10, right: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.currentProductCost.value == 2 ? LocaleKeys.paidAlready.tr : "${LocaleKeys.toBePaidByReceiver.tr}\n(${LocaleKeys.cod.tr})",
                // LocaleKeys.paidBySenderCOD.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
              Text(
                controller.currentProductCost.value == 2 ? 'HKD 1000' : "HKD ${controller.receiverValue.value}",
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ],
          ).paddingOnly(top: 8, left: 10, right: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: AppThemeState().commonDivider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.currentBalance.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
             Obx(() => Text(
               "HKD ${controller.userData.value?.merchant.accountBalance ?? ""}",
               style: _appTheme.customTextStyle(
                   fontSize: 14,
                   color: AppColors.textPrimaryColor,
                   fontWeightType: FWT.regular,
                   fontFamilyType: FFT.nunito),
             ) ) ,
            ],
          ).paddingOnly(left: 10, right: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.balanceAfterConfirmation.tr,
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
              Text(
                'HKD 4100',
                style: _appTheme.customTextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            ],
          ).paddingOnly(top: 8, left: 10, right: 10, bottom: 25),
        ],
      ),
    );
  }

  onGetShipmentQuotationView() {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Container(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              text: LocaleKeys.shipmentQuotation.tr,
              style: _appTheme.customTextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
              children: <TextSpan>[
                TextSpan(
                    text: '\nHKD ${controller.totalPrice}',
                    style:
                        TextStyle(fontSize: 24, color: AppColors.primaryColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  onGetBackIcon() {
    return InkWell(
      onTap: () {
        // Logger.dev("@71 Close Button Called");
        Get.offNamed(RouteName.homePage);
      },
      child: Padding(
        padding:
        const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
        child: SvgPicture.asset(
          SVGPath.backIcon,
          width: 25,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  //progress bar
  onGetCircularProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 4,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Calculating...',
          style: _appTheme.customTextStyle(
              fontSize: 14,
              color: AppColors.primaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ],
    );
  }
}
