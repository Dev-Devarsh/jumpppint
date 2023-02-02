import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../../utills/enum/font_type.dart';
import '../../../../../utills/generated/locales.g.dart';
import '../../../../../utills/utils.dart';
import '../../../../../utills/validator.dart';
import '../../../../common/common_app_bar.dart';
import '../../../../common/template_web.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';
import '../controlleres/delete_account_controller.dart';

class DeleteAccountView extends GetResponsiveView<DeleteAccountController> {
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
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.deleteAccount.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 27,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
          child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(scrollbars: false),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: accountBalanceInfo(),
                      ),
                      remainingBalanceInfo(),
                      accountDetailsInfro(),
                    ],
                  ),
                )),
            onGetBottomBar(),
          ],
        ),
      )),
    );
  }

  @override
  Widget? tablet() {
    return phone();
  }

  @override
  Widget? desktop() {
    return TemplateWeb(
        currentTab: 0,
        body: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
              color: AppColors.primaryColor,
              child: CommonAppBar(
                title: LocaleKeys.deleteAccount.tr,
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 27,
                centerTitle: true,
              ),
            ),
          ),
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(scrollbars: false),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: accountBalanceInfo(),
                      ).paddingSymmetric(horizontal: Get.width / 5),
                      remainingBalanceInfo(),
                      accountDetailsInfro(),
                    ],
                  ),
                ),
              ),
              onGetBottomBar()
            ],
          )),
        ));
  }

  accountBalanceInfo() {
    return Container(
        padding: const EdgeInsets.only(top: 21, bottom: 14),
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.whiteColor,
            boxShadow: [_appTheme.commonBoxShadow()]),
        child: Column(
          children: [
            Text(
              LocaleKeys.accountBalance.tr,
              textAlign: TextAlign.center,
              style: AppThemeState().customTextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryColor,
                  fontWeightType: FWT.regular,
                  fontFamilyType: FFT.nunito),
            ),
            Obx(
              () => Text(
                "HKD ${controller.userData.value?.merchant.accountBalance}",
                textAlign: TextAlign.center,
                style: AppThemeState().customTextStyle(
                    fontSize: 24,
                    color: AppColors.primaryColor,
                    fontWeightType: FWT.regular,
                    fontFamilyType: FFT.nunito),
              ),
            )
          ],
        ));
  }

  remainingBalanceInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: EdgeInsets.only(
          left: screen.isDesktop ? Get.width / 5 : 10,
          right: screen.isDesktop ? Get.width / 5 : 10,
          top: 15),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.stickyColor,
          border: Border.all(color: AppColors.primaryColor),
          boxShadow: [_appTheme.commonBoxShadow()]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.remainingBalance.tr,
            style: AppThemeState().customTextStyle(
                fontSize: 14,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          Text(
            LocaleKeys.bankAccountForRefund.tr,
            style: AppThemeState().customTextStyle(
                fontSize: 14,
                color: AppColors.textPrimaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }

  accountDetailsInfro() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      margin: EdgeInsets.only(
          left: screen.isDesktop ? Get.width / 5 : 10,
          right: screen.isDesktop ? Get.width / 5 : 10,
          top: 15),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.whiteColor,
          boxShadow: [_appTheme.commonBoxShadow()]),
      child: AnimationLimiter(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 700),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 100,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            accountBenefitiaryNameTextFormField(),
            const SizedBox(height: 15),
            bankNameTextFormField(),
            const SizedBox(height: 15),
            bankNumberTextFormField()
          ],
        ),
      )),
    );
  }

  accountBenefitiaryNameTextFormField() {
    return CustomTextFormField(
      editController: controller.accountBenefitiaryName,
      focusNode: controller.focusAccountBenefitiaryName,
      labelText: LocaleKeys.accountBenefitiaryName.tr,
      textInputType: TextInputType.name,
      onChange: (value) {},
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );
  }

  bankNameTextFormField() {
    return DropdownFormField<Map<String, dynamic>>(
      onEmptyActionPressed: () async {},
      emptyActionText: "",
      emptyText: "No matching found!",
      controller: controller.bankNameController.value,
      decoration: AppThemeState().commonDropDownDecoration(LocaleKeys.bank.tr),
      onSaved: (dynamic str) {},
      onChanged: (dynamic str) {
        print("${str['name']}");
        if (str != null) {
          controller.isBankNameFilled.value = true;
        }
      },
      validator: (dynamic str) {
        return 'Bank Name is required';
        // return Validator.emptyValidator(str);
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
      findFn: (dynamic str) async => controller.names,
      filterFn: (dynamic item, str) =>
          item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
      dropdownItemFn:
          (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
              ListTile(
        title: Text(
          item['name'],
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
        tileColor: focused
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.whiteColor,
        onTap: onTap,
      ),
    );
  }

  bankNumberTextFormField() {
    return CustomTextFormField(
      editController: controller.bankNumber,
      focusNode: controller.focusbankNumber,
      labelText: LocaleKeys.bankNumber.tr,
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.done,
      onChange: (value) {},
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );
  }

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
          ? EdgeInsets.symmetric(vertical: 10, horizontal: Get.width / 5)
          : const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 25),
      child: CommonButton(
        padding: const EdgeInsets.symmetric(vertical: 7),
        buttonText: LocaleKeys.delete.tr,
        width: Get.width,
        backgroundColor: AppColors.primaryColor,
        isBorder: false,
        textColor: AppColors.whiteColor,
        onTap: () {
            screen.isDesktop
                ? Utils.showCommonDialogWeb(
                    title: LocaleKeys.confirmDeleteText.tr,
                    positiveText: LocaleKeys.confirm.tr,
                    negativeText: LocaleKeys.cancel.tr,
                    isNegativeButtonShow: true,
                    onNegativeTap: () {
                      Get.back();
                    },
                    onTap: () {
                      controller.deleteAccount();
                      // controller.goToSadToLeaveView();
                    })
                : Utils.showCommonDialog(
                    title: LocaleKeys.confirmDeleteText.trParams({"email":controller.userData.value?.email??""}),
                    positiveText: LocaleKeys.confirm.tr,
                    negativeText: LocaleKeys.cancel.tr,
                    isNegativeButtonShow: true,
                    onNegativeTap: () {
                      Get.back();
                    },
                    onTap: () {
                      controller.deleteAccount();
                      //controller.goToSadToLeaveView();
                    });

        },
      ),
    );
  }
}
