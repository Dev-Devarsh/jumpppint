import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/custom_drawer.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/top_up_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../widgets/common_button.dart';

class TopUpView extends GetResponsiveView<TopUpController> {
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
        backgroundColor: AppColors.backgroundColor,
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: CommonAppBar(
            title: LocaleKeys.topUpC.tr,
            elevation: 0.0,
            isBackButtonVisible: false,
            leading: onGetMenuIcon(),
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        drawer: Drawer(
          child: CommonDrawer(currentIndex: RxInt(5), onLogoutClick: () {
            controller.logout();
          },),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.accountBalance.tr,
                                style: _appTheme.customTextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondaryColor,
                                    fontWeightType: FWT.regular,
                                    fontFamilyType: FFT.nunito),
                              ),
                              Obx(() =>  Text(
                                "HDK ${
                                      controller.userData.value?.merchant
                                              .accountBalance ??
                                          ""
                                    }",
                                style: _appTheme.customTextStyle(
                                    fontSize: 30,
                                    color: AppColors.primaryColor,
                                    fontWeightType: FWT.regular,
                                    fontFamilyType: FFT.nunito),
                              )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.savedCards.tr,
                              style: _appTheme.customTextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondaryColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            ),
                            controller.arguments == true
                                ? Offstage()
                                : InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          RouteName.transactionRecordView);
                                    },
                                    child: Text(
                                      LocaleKeys.transactionRecord.tr,
                                      style: _appTheme.customTextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                          fontWeightType: FWT.regular,
                                          fontFamilyType: FFT.nunito),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            child: Obx(
                              () => controller.paymentMethodList.isNotEmpty
                                  ? onGetRecordItem()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 32),
                                      child: Align(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          LocaleKeys.noNotification.tr,
                                          style: _appTheme.customTextStyle(
                                              fontSize: 14,
                                              color:
                                                  AppColors.textSecondaryColor,
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
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: onGetAddCardButton(false)),
                      const SizedBox(
                        width: 10,
                      ),
                      controller.arguments == true
                          ? Offstage()
                          : Expanded(child: onGetBankTransferButton(false)),
                    ],
                  ),
                ),
              )
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
        currentTab: 5,
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            CommonAppBar(
              title: LocaleKeys.topUpC.tr,
              elevation: 0.0,
              isBackButtonVisible: false,
              centerTitle: true,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.accountBalance.tr,
                              style: _appTheme.customTextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondaryColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            ),
                            Obx(() =>  Text(
                              "HDK ${
                                  controller.userData.value?.merchant
                                      .accountBalance ??
                                      ""
                              }",
                              style: _appTheme.customTextStyle(
                                  fontSize: 30,
                                  color: AppColors.primaryColor,
                                  fontWeightType: FWT.regular,
                                  fontFamilyType: FFT.nunito),
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: Get.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10.0, bottom: 8.0),
                        child: SizedBox(
                          width: Get.width / 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.registeredCreditCard.tr,
                                style: _appTheme.customTextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondaryColor,
                                    fontWeightType: FWT.regular,
                                    fontFamilyType: FFT.nunito),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  LocaleKeys.addCreditCard.tr,
                                  style: _appTheme.customTextStyle(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      fontWeightType: FWT.regular,
                                      fontFamilyType: FFT.nunito),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                        width: Get.width / 3,
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(
                                  () => controller.paymentMethodList.isNotEmpty
                                      ? onGetRecordItem()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(top: 32),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional.center,
                                            child: Text(
                                              LocaleKeys.noNotification.tr,
                                              style: _appTheme.customTextStyle(
                                                  fontSize: 14,
                                                  color: AppColors
                                                      .textSecondaryColor,
                                                  fontWeightType: FWT.regular,
                                                  fontFamilyType: FFT.nunito),
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                        RouteName.transactionRecordView);
                                  },
                                  child: Text(
                                    LocaleKeys.transactionHistory.tr,
                                    style: _appTheme.customTextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                        fontWeightType: FWT.regular,
                                        fontFamilyType: FFT.nunito),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Center(
        child: Text(
          str,
          textAlign: TextAlign.center,
          style: AppThemeState().customTextStyle(
              fontSize: fontSize,
              color: color,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ),
    );
  }

  Widget onGetMenuIcon() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
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

  onGetAddCardButton(bool isFromWeb) {
    return CommonButton(
      buttonText: controller.arguments == true
          ? LocaleKeys.addNewCard.tr
          : LocaleKeys.addCard.tr,
      backgroundColor: AppColors.primaryColor,
      isBorder: false,
      textColor: AppColors.whiteColor,
      onTap: () {
        controller.getAddCardURL();
      },
    );
  }

  onGetBankTransferButton(bool isFromWeb) {
    return CommonButton(
      buttonText: LocaleKeys.bankTransfer.tr,
      backgroundColor: AppColors.primaryColor,
      isBorder: false,
      textColor: AppColors.whiteColor,
      onTap: () {
        Get.toNamed(RouteName.bankTransferView);
      },
    );
  }

  onGetRecordItem() {
    return AnimationLimiter(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.paymentMethodList.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 700),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.paymentMethodList[index]?.paymentMethod?.name ?? "",
                                          style: _appTheme.customTextStyle(
                                              fontSize: 14,
                                              color: AppColors.textPrimaryColor,
                                              fontWeightType: FWT.regular,
                                              fontFamilyType: FFT.nunito),
                                        ),
                                        Text(
                                          "XXXX-XXXX-XXXX-${controller.paymentMethodList[index]?.paymentMethod?.last4 ?? ""}",
                                          style: _appTheme.customTextStyle(
                                              fontSize: 14,
                                              color: AppColors.textSecondaryColor,
                                              fontWeightType: FWT.regular,
                                              fontFamilyType: FFT.nunito),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    controller.paymentMethodList[index]?.paymentMethod?.brand != ""
                                        ? SVGPath.visa
                                    : SVGPath.masterCard,
                                    width: 45,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Text(
                                    LocaleKeys.expiry.tr,
                                    style: _appTheme.customTextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondaryColor,
                                        fontWeightType: FWT.regular,
                                        fontFamilyType: FFT.nunito),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${controller.paymentMethodList[index]?.paymentMethod?.expiryMonth ?? ""}/${controller.paymentMethodList[index]?.paymentMethod?.expiryYear ?? ""}",
                                    style: _appTheme.customTextStyle(
                                        fontSize: 14,
                                        color: AppColors.textPrimaryColor,
                                        fontWeightType: FWT.regular,
                                        fontFamilyType: FFT.nunito),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                color: AppColors.borderColor,
                                width: double.infinity,
                                height: 1,
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {
                                        screen.isDesktop
                                            ? Utils.showCommonDialogWeb(
                                                title: LocaleKeys.removeCard.tr,
                                                positiveText: LocaleKeys.confirm.tr,
                                                negativeText: LocaleKeys.cancel.tr,
                                                isNegativeButtonShow: true,
                                                onNegativeTap: () {
                                                  Get.back();
                                                },
                                                onTap: () {
                                                  Get.back();
                                                })
                                            : Utils.showCommonDialog(
                                                title: LocaleKeys.removeCard.tr,
                                                positiveText: LocaleKeys.confirm.tr,
                                                negativeText: LocaleKeys.cancel.tr,
                                                isNegativeButtonShow: true,
                                                onNegativeTap: () {
                                                  Get.back();
                                                },
                                                onTap: () {
                                                  Get.back();
                                                });
                                      },
                                      child: Text(
                                        LocaleKeys.remove.tr,
                                        style: _appTheme.customTextStyle(
                                            fontSize: 14,
                                            color: AppColors.textSecondaryColor,
                                            fontWeightType: FWT.regular,
                                            fontFamilyType: FFT.nunito),
                                      ),
                                    ),
                                  ),
                                  // VerticalDivider(color: AppColors.textSecondaryColor),
                                  Container(
                                    width: 1,
                                    height: double.infinity,
                                    color: AppColors.borderColor,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.getPaymentTopUpAmountOption();
                                    },
                                    child: Text(
                                      LocaleKeys.topUpC.tr,
                                      style: _appTheme.customTextStyle(
                                          fontSize: 14,
                                          color: AppColors.primaryColor,
                                          fontWeightType: FWT.regular,
                                          fontFamilyType: FFT.nunito),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
