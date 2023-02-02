import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/top_up_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../widgets/common_button.dart';

class TopUpBalanceView extends GetResponsiveView<TopUpController> {
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
            isBackButtonVisible: true,
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
        body: Obx(() => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 12, bottom: 20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  onGetKnowUsDropDown(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  onJarvixPayButton(false),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                      child: Column(
                        children: [
                          onConfirmButton(false),
                          const SizedBox(
                            height: 5,
                          ),
                          onResetButton(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  @override
  Widget? tablet() {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: CommonAppBar(
              title: LocaleKeys.topUpC.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              leadingWidth: 50,
              centerTitle: true,
            ),
          ),
          body: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 12, bottom: 20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  onGetKnowUsDropDown(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  onJarvixPayButton(false),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                      child: Column(
                        children: [
                          onConfirmButton(false),
                          const SizedBox(
                            height: 5,
                          ),
                          onResetButton(),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  @override
  Widget? desktop() {
    print("TempLate");
    return TemplateWeb(
        currentTab: 5,
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width/4.5),
                color: AppColors.primaryColor,
                child: CommonAppBar(
                  title: LocaleKeys.topUpC.tr,
                  elevation: 0.0,
                  isBackButtonVisible: true,
                  leadingWidth: 20,
                  centerTitle: true,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  width: Get.width / 3,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 12,
                                        bottom: 20),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          onGetKnowUsDropDown(),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          onJarvixPayButton(true),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
                              child: Column(
                                children: [
                                  onConfirmButton(true),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  onResetButton(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: AppColors.whiteColor,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(8),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Expanded(child: onGetAddCardButton(false)),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Expanded(child: onGetBankTransferButton(false)),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ));
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

  final List<Map<String, dynamic>> _amount = [
    {"amount": "1000", "index": 1},
    {"amount": "2000", "index": 2},
    {"amount": "3000", "index": 3},
    {"amount": "4000", "index": 4},
    {"amount": "5000", "index": 5},
    {"amount": "6000", "index": 6},
  ];

  onGetKnowUsDropDown() {
    return DropdownFormField<dynamic>(
      onEmptyActionPressed: () async {},
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        errorMaxLines: 3,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            size: 30,
            Icons.arrow_drop_down_rounded,
            color: AppColors.textSecondaryColor,
          ),
        ),
        errorStyle: AppThemeState().customTextStyle(
            fontSize: 12,
            fontFamilyType: FFT.nunito,
            color: AppColors.primaryColor,
            fontWeightType: FWT.regular),
        labelText: LocaleKeys.topAmount.tr,
        labelStyle: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular),
        filled: true,
        fillColor: AppColors.whiteColor,
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
        // if (str['amount'] != "") {
        controller.clearFocus();
        if (str != null) {
          print(str);
          controller.amount.value = true;
        }
      },
      validator: (dynamic str) {
        if (str == null) {
          return LocaleKeys.errorAmount.tr;
        }
        // else {
        // }
        // print(str);
        // print(str['amount']);
        // return Validator.emptyTopAmountValidator(str['amount']);
      },
      displayItemFn: (dynamic item) => Text(
        controller.amount.value
            ? item != null
                ? item.toString()
                : ''
            : '',
        style: AppThemeState().customTextStyle(
            fontSize: 14,
            fontFamilyType: FFT.nunito,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular),
      ),
      findFn: (dynamic str) async => controller.amountOptionsList,
      filterFn: (dynamic item, str) =>
          item,
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item.toString(),
          style: AppThemeState().customTextStyle(
              fontSize: 14,
              fontFamilyType: FFT.nunito,
              color: AppColors.textSecondaryColor,
              fontWeightType: FWT.regular),
        ),
        tileColor:
            focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
        onTap: onTap,
      ),
    );
  }

  onJarvixPayButton(bool isFromWeb) {
    return CommonButton(
      buttonText: LocaleKeys.jarvixPay.tr,
      // width: isFromWeb ? Get.width / 16 : Get.width / 4,
      padding: EdgeInsets.only(left: 20,right: 20),
      isBorder: false,
      backgroundColor: AppColors.dartBlueColor,
      textColor: AppColors.whiteColor,
      isItalic: true,
      onTap: () {},
    );
  }

  onConfirmButton(bool isFromWeb) {
    return CommonButton(
      buttonText: LocaleKeys.confirm.tr,
      width: isFromWeb ? Get.width / 3 : Get.width,
      isBorder: false,
      backgroundColor: controller.amount.value
          ? AppColors.primaryColor
          : AppColors.disableColor,
      textColor: controller.amount.value
          ? AppColors.whiteColor
          : AppColors.lightGreyColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          Get.toNamed(RouteName.topUpSuccessfully);
          Logger.dev("CommonButton");
        } else {
          Logger.dev("@151 Validate Failed");
        }
      },
    );
  }

  onResetButton() {
    return CommonButton(
      buttonText: LocaleKeys.reset.tr,
      width: Get.width,
      backgroundColor: Colors.transparent,
      isBorder: false,
      textColor: AppColors.primaryColor,
      onTap: () {
        controller.amount.value = false;
        controller.clearFocus();
        // if (formKey.currentState!.validate()) {
        //   Logger.dev("@149 Login Button Tap");
        // } else {
        //   Logger.dev("@151 Validate Failed");
        // }
      },
    );
  }

}
