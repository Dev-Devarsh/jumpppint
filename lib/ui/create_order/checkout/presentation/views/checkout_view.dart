import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../../routes.dart';
import '../../../../../utills/app_theme.dart';
import '../../../../../utills/asset_images.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../../utills/validator.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';
import '../../../common/create_order_template.dart';
import '../../../common/create_order_template_web.dart';
import '../../../type/presentation/controllers/type_controller.dart';

class CheckoutView extends GetResponsiveView<TypeController> {
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
    return CreateOrderTemplate(
      scaffoldKey: scaffoldKey,
      formKey: formKey,
      screen: screen,
      leadingWidth: 50,
      closeButtonWidget: onGetBackIcon(),
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                onGetMainLayout(),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
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
    return CreateOrderTemplateWeb(
      formKey: formKey,
      screen: screen,
      currentTab: 1,
      isBackButtonVisible:true,
      bottomBar: onGetBottomBar(),
      body: Expanded(
        child: ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width/5),
              child: Column(
                children: [
                  onGetMainLayout(),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MOBILE

  onGetBackIcon() {
    return InkWell(
      onTap: () {
        // Logger.dev("@71 Close Button Called");
        controller.currentTab.value = 2;
        Get.back();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 16),
        child: SvgPicture.asset(
          SVGPath.backIcon,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  onGetMainLayout() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [AppThemeState().commonBoxShadow()],
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: screen.isDesktop ? 0 : 10,
        right: screen.isDesktop ? 0 : 10,
      ),
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
        left: 10,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.shippingCost.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 7,
          ),
          onGetShipmentRadioLayout(LocaleKeys.toBePaidBySender.tr, 0),
          const SizedBox(
            height: 15,
          ),
          onGetShipmentRadioLayout(LocaleKeys.toBePaidByReceiver.tr, 1),
          const SizedBox(
            height: 25,
          ),
          Text(
            LocaleKeys.productCost.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 7,
          ),
          onGetProductCostRadioLayout(LocaleKeys.paidAlready.tr, 2),
          const SizedBox(
            height: 15,
          ),
          onGetProductCostRadioLayout(
              "${LocaleKeys.toBePaidByReceiver.tr} ${LocaleKeys.cod.tr}", 3),
          Obx(
            () => controller.currentProductCost.value == 3
                ? const SizedBox(
                    height: 15,
                  )
                : const Offstage(),
          ),
          Obx(
            () => controller.currentProductCost.value == 3
                ? CustomTextFormField(
                    editController: controller.editReceiverPaymentController,
                    focusNode: controller.focusReceiverPayment,
                    labelText: LocaleKeys.productCostToChargeCustomer.tr,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.number,
                    onChange: (value) {
                      controller.receiverValue.value = value.toString();
                    },
                    onValidate: (value) {
                      return Validator.emptyValidator(value);
                    })
                : const Offstage(),
          ),
          Obx(() => controller.currentProductCost.value == 3
              ? const SizedBox(
                  height: 7,
                )
              : const Offstage()),
          Obx(() => controller.currentProductCost.value == 3
              ? Text(
                  LocaleKeys.courierChargeNotes.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                )
              : const Offstage()),
          /*const SizedBox(
            height: 25,
          ),
          Text(
            LocaleKeys.insurance.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      value: controller.isChecked.value,
                      side: const BorderSide(width: 1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                      checkColor: AppColors.whiteColor,
                      onChanged: (bool? value) {
                        controller.isChecked.value = value ?? false;
                      }),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: screen.isDesktop ? Get.width * 0.23 : Get.width - 100,
                child: RichText(
                  text: TextSpan(
                    text:
                        'Protect your shipment with insurance by \$123 For insurance details, ',
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'click here',
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: AppColors.primaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => controller.isChecked.value
                ? const SizedBox(
                    height: 15,
                  )
                : const Offstage(),
          ),
          Obx(
            () => controller.isChecked.value
                ? CustomTextFormField(
                    editController: controller.editShipmentValueController,
                    focusNode: controller.focusShipmentValue,
                    labelText: LocaleKeys.shipmentValue.tr,
                    textInputType: TextInputType.number,
                    onChange: (value) {
                      controller.shipmentValue.value = value.toString();
                    },
                    onValidate: (value) {
                      return Validator.emptyValidator(value);
                    })
                : const Offstage(),
          ),
          Obx(() => controller.isChecked.value
              ? const SizedBox(
                  height: 7,
                )
              : const Offstage()),
          Obx(() => controller.isChecked.value
              ? Text(
                  LocaleKeys.forInsuranceClearanceMessage.tr,
                  style: _appTheme.customTextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryColor,
                      fontWeightType: FWT.regular,
                      fontFamilyType: FFT.nunito),
                )
              : const Offstage()),*/
          /*Obx(
            () => controller.currentType.value == 2
                ? onGetExpressDetailsLayout()
                : const Offstage(),
          )*/
        ],
      ),
    );
  }

  onGetStandardLayout(String title, String notes) {
    return Obx(
      () => controller.currentType.value == 1
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 11, bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SVGPath.radioSelectedIcon,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: Get.width - 120,
                        child: Text(
                          notes,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = 1;
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      SVGPath.radioUnSelectedIcon,
                      color: AppColors.stateDisableColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  onGetExpressLayout(String title, String notes) {
    return Obx(
      () => controller.currentType.value == 2
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 11, bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SVGPath.radioSelectedIcon,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: _appTheme.customTextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeightType: FWT.regular,
                            fontFamilyType: FFT.nunito),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      SizedBox(
                        width: Get.width - 120,
                        child: Text(
                          notes,
                          style: _appTheme.customTextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondaryColor,
                              fontWeightType: FWT.regular,
                              fontFamilyType: FFT.nunito),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentType.value = 2;
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      SVGPath.radioUnSelectedIcon,
                      color: AppColors.stateDisableColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  onGetBottomBar() {
    return Obx(
      () => Container(
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
              buttonText: LocaleKeys.getQuotation.tr,
              width: Get.width,
              backgroundColor: onGetStatus()
                  ? AppColors.primaryColor
                  : AppColors.disableColor,
              isBorder: false,
              textColor: onGetStatus()
                  ? AppColors.whiteColor
                  : AppColors.stateDisableColor,
              onTap: () {
                if (onGetStatus()) {
                  Utils.showProgressDialog(title: "Calculating");
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      Get.back();
                      controller.getShipmentPreviewQuotation();
                      // Get.offAllNamed(RouteName.shipmentPreviewPage);
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => CommonButton(
                buttonText: LocaleKeys.reset.tr,
                width: Get.width,
                backgroundColor: AppColors.whiteColor,
                isBorder: false,
                textColor: onGetStatus()
                    ? AppColors.primaryColor
                    : AppColors.stateDisableColor,
                onTap: () {
                    controller.resetCheckoutView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onGetShipmentRadioLayout(title, index) {
    return Obx(
      () => controller.currentShipmentCost.value == index
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.primaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 11, bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SVGPath.radioSelectedIcon,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ).paddingOnly(bottom: 3),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentShipmentCost.value = index;
                controller.shipmentPaymentOptions = controller.paymentOptions[index];
                print("shipmentPaymentOptions - ${controller.shipmentPaymentOptions}");
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 11, bottom: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      SVGPath.radioUnSelectedIcon,
                      color: AppColors.stateDisableColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ).paddingOnly(bottom: 3),
                  ],
                ),
              ),
            ),
    );
  }

  onGetProductCostRadioLayout(title, index) {
    return Obx(
      () => controller.currentProductCost.value == index
          ? Container(
              width: Get.width,
              decoration: BoxDecoration(

                color: AppColors.primaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 11, bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    SVGPath.radioSelectedIcon,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: _appTheme.customTextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        fontWeightType: FWT.regular,
                        fontFamilyType: FFT.nunito),
                  ),
                ],
              ),
            )
          : InkWell(
              onTap: () {
                controller.currentProductCost.value = index;
                controller.receiverPaymentOptions = controller.paymentOptions[index];
                print("receiverPaymentOptions - ${controller.receiverPaymentOptions}");
                controller.isSelectProductCostFilled.value = false;
              },
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: AppThemeState().commonBorder()),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      SVGPath.radioUnSelectedIcon,
                      color: AppColors.stateDisableColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: _appTheme.customTextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimaryColor,
                          fontWeightType: FWT.regular,
                          fontFamilyType: FFT.nunito),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  onGetStatus() {
    bool isTrue = false;
    if (controller.currentShipmentCost.value != (-1) &&
        controller.currentProductCost.value == 2) {
      isTrue = true;
    } else if (controller.currentShipmentCost.value != (-1) &&
        controller.currentProductCost.value == 3 &&
        controller.receiverValue.value.isNotEmpty) {
      isTrue = true;
    }
    if (controller.isChecked.value && controller.shipmentValue.value.isEmpty) {
      isTrue = false;
    }
    return isTrue;
  }
}
