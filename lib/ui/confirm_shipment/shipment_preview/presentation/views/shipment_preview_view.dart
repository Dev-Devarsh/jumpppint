import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/confirm_shipment/shipment_preview/presentation/controllers/shipment_preview_controller.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';

class ConfirmShipmentPreviewView
    extends GetResponsiveView<ConfirmShipmentPreviewController> {
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
          title: LocaleKeys.shipmentDetails.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Column(
                    children: [
                      onGetShipmentQuotationView(),
                      onGetDetailsTabView()
                    ],
                  ),
                ],
              )),
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
      currentTab: 2,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
            color: AppColors.primaryColor,
            child: CommonAppBar(
              title: LocaleKeys.shipmentDetails.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 27,
              centerTitle: true,
            ),
          ),
          Expanded(
            child: ListView(children: [
              Column(
                children: [onGetShipmentQuotationView(), onGetDetailsTabView()],
              ),
            ]),
          ),
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
                    text: '\nHKD 900',
                    style:
                        TextStyle(fontSize: 24, color: AppColors.primaryColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  onGetDetailsTabView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screen.isDesktop ? Get.width / 5 : 0,vertical: 10),
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
                  LocaleKeys.type.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
                Text(
                  LocaleKeys.expressDelivery.tr,
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
                  '2022-03-29 (二)',
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
                  '2022-03-28 (一)',
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
                      text: 'Kelly_Chan\n',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                      children: <TextSpan>[
                        TextSpan(
                            text: '+852 9123 9321\n',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondaryColor)),
                        TextSpan(
                            text: '新界元朗洪水橋洪堤路 2 號錦珊園地下 2 號舖',
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
                      text: 'John Doe\n',
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                      children: <TextSpan>[
                        TextSpan(
                            text: '+852 9123 9321\n',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondaryColor)),
                        TextSpan(
                            text: '新界元朗洪水橋洪堤路 2 號錦珊園地下 2 號舖',
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
            Row(
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
            ),
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
                  LocaleKeys.paidBySenderCOD.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
                Text(
                  'HKD 1000',
                  style: _appTheme.customTextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                ),
              ],
            ).paddingOnly(top: 8, left: 10, right: 10, bottom: 15),
            //padding 15 to 10
          ],
        ),
      ),
    );
  }
}
