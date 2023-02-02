import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:jumppoint_app/ui/banktransfer/presentation/controllers/bank_transfer_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';

import '../../../../routes.dart';
import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../../utills/enum/font_type.dart';
import '../../../../utills/generated/locales.g.dart';
import '../../../common/common_app_bar.dart';

class BankTransferView extends GetResponsiveView<BankTransferController> {
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
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.bankTransfer.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 27,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 80, 10, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        onCommonTextFormField(
                            LocaleKeys.jumpPointBankAccountDetails.tr,
                            16,
                            AppColors.textSecondaryColor),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: onCommonTextFormField(LocaleKeys.bank.tr, 18,
                                AppColors.textSecondaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: onCommonTextFormField(LocaleKeys.hsBank.tr,
                                24, AppColors.textPrimaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: onCommonTextFormField(
                                LocaleKeys.bankNumber.tr,
                                16,
                                AppColors.textSecondaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: onCommonTextFormField("123-456789-018", 24,
                                AppColors.textPrimaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: onCommonTextFormField(LocaleKeys.copy.tr, 18,
                                AppColors.primaryColor)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: [AppThemeState().commonBoxShadow()]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 35),
                  child: CommonButton(
                      width: double.infinity,
                      height: 45,
                      textColor: AppColors.whiteColor,
                      buttonText: LocaleKeys.uploadProof.tr,
                      isBorder: false,
                      onTap: () {
                        Get.toNamed(RouteName.uploadCompletedView);
                      }),
                ),
              ),
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(Get.width, 60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 292),
            color: AppColors.primaryColor,
            child: CommonAppBar(
              title: LocaleKeys.bankTransfer.tr,
              elevation: 0.0,
              isBackButtonVisible: true,
              // leading: onGetBackIcon(),
              leadingWidth: 20,
              centerTitle: true,
            ),
          ),
        ),
        body: Container(
          color: AppColors.backgroundColor,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 80, 10, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        onCommonTextFormField(
                            LocaleKeys.jumpPointBankAccountDetails.tr,
                            16,
                            AppColors.textSecondaryColor),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: onCommonTextFormField(LocaleKeys.bank.tr, 18,
                                AppColors.textSecondaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: onCommonTextFormField(LocaleKeys.hsBank.tr,
                                24, AppColors.textPrimaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: onCommonTextFormField(
                                LocaleKeys.bankNumber.tr,
                                16,
                                AppColors.textSecondaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: onCommonTextFormField("123-456789-018", 24,
                                AppColors.textPrimaryColor)),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: onCommonTextFormField(LocaleKeys.copy.tr, 18,
                                AppColors.primaryColor)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    boxShadow: [AppThemeState().commonBoxShadow()]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 35),
                  child: CommonButton(
                      width: double.infinity,
                      height: 45,
                      textColor: AppColors.whiteColor,
                      buttonText: LocaleKeys.uploadProof.tr,
                      isBorder: false,
                      onTap: () {
                        Get.toNamed(RouteName.uploadCompletedView);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onCommonTextFormField(String str, double fontSize, Color color) {
    return Center(
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: AppThemeState().customTextStyle(
            fontSize: fontSize,
            color: color,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }
}
