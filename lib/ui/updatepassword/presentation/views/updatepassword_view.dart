import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/common/template_web.dart';
import 'package:jumppoint_app/ui/updatepassword/presentation/controllers/updatepassword_controller.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';

class UpdatePasswordView extends GetResponsiveView<UpdatePasswordController> {
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
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.updatePass.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: Wrap(children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 10),
                      child: AnimationLimiter(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 700),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 100,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            onOldPassTextFormField(false),
                            const SizedBox(
                              height: 20,
                            ),
                            onNewPassTextFormField(false),
                            const SizedBox(
                              height: 20,
                            ),
                            onConfirmNewPassTextFormField(false),
                          ],
                        ),
                      )),
                    ),
                  ),
                ]),
              ),
              Container(
                color: AppColors.whiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: onConfirmButton(false),
                    ),
                    onClearButton(false),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
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
        currentTab: 8,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PreferredSize(
              preferredSize: Size(Get.width, 50),
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                color: AppColors.primaryColor,
                child: CommonAppBar(
                  title: LocaleKeys.updatePass.tr,
                  elevation: 0.0,
                  isBackButtonVisible: true,
                  leadingWidth: 50,
                  centerTitle: true,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 20, left: 15, right: 15),
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 5),
                  child: Form(
                    key: formKey,
                    child: AnimationLimiter(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 700),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 100,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          onOldPassTextFormField(true),
                          const SizedBox(
                            height: 20,
                          ),
                          onNewPassTextFormField(true),
                          const SizedBox(
                            height: 20,
                          ),
                          onConfirmNewPassTextFormField(true),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 5),
                    child: onConfirmButton(true),
                  ),
                  onClearButton(true),
                ],
              ),
            )
          ],
        ));
  }

  onOldPassTextFormField(bool isWeb) {
    return CustomTextFormField(
      editController: controller.editOldPass,
      focusNode: controller.focusOldPass,
      isPassword: true,
      labelText: LocaleKeys.oldPass.tr,
      backgroundColor: AppColors.whiteColor,
      textInputType: TextInputType.name,
      onChange: (value) {
        controller.oldPassStr.value = value!;
      },
      onValidate: (value) {
        return Validator.emptyValidator(value);
      },
    );
  }

  onNewPassTextFormField(bool isWeb) {
    return CustomTextFormField(
      editController: controller.editNewPass,
      focusNode: controller.focusNewPass,
      labelText: LocaleKeys.newPassword.tr,
      textInputType: TextInputType.visiblePassword,
      isDenySpaces: true,
      isPassword: true,
      backgroundColor: AppColors.whiteColor,
      onChange: (value) {
        controller.newPassStr.value = value!;
      },
      onValidate: (value) {
        return Validator.passwordValidator(value);
      },
    );
  }

  onConfirmNewPassTextFormField(bool isWeb) {
    return CustomTextFormField(
      editController: controller.editConfirmNewPass,
      focusNode: controller.focusConfirmNewPass,
      labelText: LocaleKeys.confirmNewPass.tr,
      textInputType: TextInputType.visiblePassword,
      isDenySpaces: true,
      textInputAction: TextInputAction.done,
      isPassword: true,
      backgroundColor: AppColors.whiteColor,
      onChange: (value) {
        controller.confirmPassStr.value = value!;
      },
      onValidate: (value) {
        return Validator.passwordValidator(value);
      },
    );
  }

  onClearButton(bool isWeb) {
    return CommonButton(
      buttonText: LocaleKeys.clear.tr,
      backgroundColor: AppColors.whiteColor,
      isBorder: false,
      textColor: AppColors.appBarColor,
      onTap: () {
        controller.editOldPass.text = "";
        controller.editNewPass.text = "";
        controller.editConfirmNewPass.text = "";
      },
    );
  }

  onConfirmButton(bool isWeb) {
    return Obx(() => CommonButton(
          buttonText: LocaleKeys.confirm.tr,
          width: Get.width,
          backgroundColor: controller.oldPassStr.value.isNotEmpty &&
                  controller.newPassStr.value.isNotEmpty &&
                  controller.confirmPassStr.value.isNotEmpty
              ? AppColors.primaryColor
              : AppColors.disableColor,
          isBorder: false,
          textColor: controller.oldPassStr.value.isNotEmpty &&
                  controller.newPassStr.value.isNotEmpty &&
                  controller.confirmPassStr.value.isNotEmpty
              ? AppColors.whiteColor
              : AppColors.lightGreyColor,
          onTap: () {
            if (controller.oldPassStr.value.isNotEmpty &&
                controller.newPassStr.value.isNotEmpty &&
                controller.confirmPassStr.value.isNotEmpty &&
                formKey.currentState!.validate()) {
              controller.getPatchResetPassword();
            } else {
              showAlertDialog();
              Logger.dev("@151 Validate Failed");
            }
          },
        ).paddingOnly(top: 10));
  }

  void showAlertDialog() async {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(LocaleKeys.wrongPass.tr,
                  style: TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontType.getFontWeightType(FWT.regular),
                      fontFamily: FontType.getFontFamilyType(FFT.nunito)))),
          actions: <Widget>[
            Divider(height: 1, color: AppColors.borderColor),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                child: Text(LocaleKeys.ok.tr,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontType.getFontWeightType(FWT.regular),
                        fontFamily: FontType.getFontFamilyType(FFT.nunito))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
