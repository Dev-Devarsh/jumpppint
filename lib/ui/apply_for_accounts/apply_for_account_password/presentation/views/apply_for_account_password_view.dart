import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account/presentation/controllers/apply_for_account_controller.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';

class ApplyForAccountPasswordView
    extends GetResponsiveView<ApplyForAccountController> {
  final AppThemeState _appTheme = AppThemeState();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget? builder() {
    controller.clearFocus();
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
            title: LocaleKeys.registration.tr,
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Form(
                              key: controller.formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  onGetPasswordTextFormField(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  onGetConfirmPasswordTextFormField(),
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
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          onGetNextButton(),
                          const SizedBox(
                            height: 5,
                          ),
                          onGetFAQButton(),
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
    return phone();
  }

  @override
  Widget? desktop() {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundColor,
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 3.5),
              color: AppColors.primaryColor,
              child: CommonAppBar(
                title: LocaleKeys.registration.tr,
                elevation: 0.0,
                isBackButtonVisible: true,
                leadingWidth: 50,
                centerTitle: true,
              ),
            ),
          ),
          body: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: Get.width/3.5),
                        padding: EdgeInsets.all(8),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              onGetPasswordTextFormField(),
                              const SizedBox(
                                height: 15,
                              ),
                              onGetConfirmPasswordTextFormField(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: Get.width/3.5),
                    child: Column(
                      children: [
                        onGetNextButton(),
                        const SizedBox(
                          height: 5,
                        ),
                        onGetFAQButton(),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  onGetPasswordTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConPassword,
      focusNode: controller.focusPassword,
      isPassword: true,
      isDenySpaces: true,
      labelText: LocaleKeys.passwordLabel.tr,
      textInputType: TextInputType.visiblePassword,
      onChange: (value) {
        controller.password.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.passwordValidator(value);
      },
    );
  }

  onGetConfirmPasswordTextFormField() {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: controller.editConConfirmPassword,
      focusNode: controller.focusConfirmPassword,
      labelText: LocaleKeys.confirmPassword.tr,
      isPassword: true,
      textInputAction: TextInputAction.done,
      isDenySpaces: true,
      textInputType: TextInputType.visiblePassword,
      onChange: (value) {
        controller.confirmPassword.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.confirmPasswordValidator(
            value, controller.editConPassword.text.toString());
      },
    );
  }

  onGetNextButton() {
    return CommonButton(
      buttonText: LocaleKeys.nextApplyForAccount.tr,
      width: Get.width,
      isBorder: false,
      backgroundColor: controller.password.value.isNotEmpty &&
              controller.confirmPassword.value.isNotEmpty
          ? AppColors.primaryColor
          : AppColors.disableColor,
      textColor: controller.password.value.isNotEmpty
          // controller.formKey.currentState!.validate()
          ? AppColors.whiteColor
          : AppColors.lightGreyColor,
      onTap: () {
        if (controller.password.value.isNotEmpty &&
            controller.formKey.currentState!.validate() &&
            controller.confirmPassword.value.isNotEmpty) {
          controller.editConPassword.text = "";
          controller.editConConfirmPassword.text = "";
          controller.onGetRegister();
          Logger.dev("@239 Register API call");
        } else {
          Logger.dev("@151 Validate Failed");
        }
      },
    );
  }

  onGetFAQButton() {
    return CommonButton(
      buttonText: LocaleKeys.faq.tr,
      width: Get.width,
      backgroundColor: Colors.transparent,
      isBorder: false,
      textColor: AppColors.primaryColor,
      onTap: () {
        if (controller.formKey.currentState!.validate()) {
          Logger.dev("@149 Login Button Tap");
        } else {
          Logger.dev("@151 Validate Failed");
        }
      },
    );
  }
}
