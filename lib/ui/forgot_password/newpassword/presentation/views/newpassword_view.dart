import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/presentation/controllers/forgotpassword_controller.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../../utills/app_theme.dart';
import '../../../../../utills/colors.dart';
import '../../../../widgets/common_button.dart';
import '../../../../widgets/common_textformfield.dart';

class NewPasswordView extends GetResponsiveView<ForgotPasswordController> {
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
          title: LocaleKeys.forgetPass.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
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
                    // color: AppColors.whiteColor,
                    child: Form(
                      key: formKey,
                      child: AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 700),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 100,
                              child: FadeInAnimation(
                                child: widget,
                              ),
                            ),
                          children: [
                            onGetTextFormField(
                                LocaleKeys.newPassword.tr,
                                controller.editNewPass,
                                controller.focusNewPass),
                            const SizedBox(
                              height: 20,
                            ),
                            onGetTextFormField(
                                LocaleKeys.resetPassword.tr,
                                controller.editResetPass,
                                controller.focusResetPass),
                          ],)
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  onGetSignInButton(),
                  onGetResetButton(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget? tablet() {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: CommonAppBar(
          title: LocaleKeys.forgetPass.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 20,
          centerTitle: true,
        ),
      ),

      // resizeToAvoidBottomInset: true,
      body: Column(
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
                  // color: AppColors.whiteColor,
                  child: Form(
                    key: formKey,
                    child: AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 700),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 100,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                        children: [
                          onGetTextFormField(LocaleKeys.newPassword.tr,
                              controller.editNewPass, controller.focusNewPass),
                          const SizedBox(
                            height: 20,
                          ),
                          onGetTextFormField(
                              LocaleKeys.resetPassword.tr,
                              controller.editResetPass,
                              controller.focusResetPass),
                        ],
                      ),)
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Container(
            color: AppColors.whiteColor,
            child: Column(
              children: [
                onGetSignInButton(),
                onGetResetButton(),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget? desktop() {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width/3.1),
          color: AppColors.primaryColor,
          child: CommonAppBar(
            title: LocaleKeys.forgetPass.tr,
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
      ),
      // resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: Get.width / 3,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    // color: AppColors.whiteColor,
                    child: Form(
                      key: formKey,
                      child: AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 700),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              verticalOffset: 100,
                              child: FadeInAnimation(
                                child: widget,
                              ),
                            ),
                          children: [
                            onGetTextFormField(LocaleKeys.newPassword.tr,
                                controller.editNewPass, controller.focusNewPass),
                            const SizedBox(
                              height: 20,
                            ),
                            onGetTextFormField(
                                LocaleKeys.resetPassword.tr,
                                controller.editResetPass,
                                controller.focusResetPass,
                                isResetPassword: true),
                          ],)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Center(
            child: Container(
              width: Get.width,
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  onGetSignInButton(),
                  onGetResetButton(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
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
            // color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetTextFormField(
      String lblTxt, TextEditingController editController, FocusNode focusNode,
      {bool? isResetPassword}) {
    return CustomTextFormField(
      backgroundColor: AppColors.whiteColor,
      editController: editController,
      focusNode: focusNode,
      isPassword: true,
      isDenySpaces: true,
      labelText: lblTxt,
      textInputType: TextInputType.visiblePassword,
      onChange: (value) {},
      onValidate: (value) {
        return Validator.passwordValidator(value);
      },
    );
  }

  onGetSignInButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: CommonButton(
          buttonText: LocaleKeys.confirm.tr,
          width: screen.isDesktop ? Get.width / 3 : Get.width,
          backgroundColor: AppColors.appBarColor,
          isBorder: false,
          textColor: AppColors.whiteColor,
          onTap: (){
            if (formKey.currentState!.validate()) {
              //Get.offAllNamed(RouteName.root);
              controller.onChangePassword();
            }
          }),
    );
  }

  onGetResetButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: CommonButton(
          buttonText: LocaleKeys.reset.tr,
          width: screen.isDesktop ? Get.width / 3 : Get.width,
          backgroundColor: AppColors.whiteColor,
          isBorder: false,
          textColor:  AppColors.appBarColor,
          onTap: (){
            controller.editNewPass.text = "";
            controller.editResetPass.text = "";
          }),
    );
  }

}
