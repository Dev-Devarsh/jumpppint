import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/presentation/controllers/forgotpassword_controller.dart';
import 'package:jumppoint_app/ui/widgets/common_button.dart';
import 'package:jumppoint_app/ui/widgets/common_textformfield.dart';
import 'package:jumppoint_app/utills/app_theme.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/validator.dart';

class ForgotPasswordView extends GetResponsiveView<ForgotPasswordController> {
  final AppThemeState _appTheme = AppThemeState();
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
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formKey,
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          const SizedBox(
                            height: 110,
                          ),
                          SvgPicture.asset(
                            SVGPath.ForgotPassIcon,
                            width: 100,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          onCommonTextFormField(LocaleKeys.smsVerificationCode.tr, 20,
                              AppColors.textPrimaryColor),
                          const SizedBox(
                            height: 25,
                          ),
                          Obx(() =>  onCommonTextFormField(LocaleKeys.smsSent.trParams({"number": controller.phoneNumber.value}),
                              16, AppColors.textSecondaryColor)),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: onGetEmailTextFormField(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Obx(() => controller.enableResend.value ?
                          GestureDetector(
                            onTap: (){
                              controller.onResendOTP();
                            },
                            child: onCommonTextFormField(LocaleKeys.resentOtp.tr, 14, AppColors.primaryColor),
                          ): onCommonTextFormField(LocaleKeys.resentOtpCount.trParams({"count":"${controller.secondsRemaining.value}s"}), 14, AppColors.disableColor))
                        ],)
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: AppColors.whiteColor,
                  child: onGetSignInButton()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget? tablet() {
    return Scaffold(
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
      body: SafeArea(
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: formKey,
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          const SizedBox(
                            height: 110,
                          ),
                          SvgPicture.asset(
                            SVGPath.ForgotPassIcon,
                            width: 100,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          onCommonTextFormField(LocaleKeys.smsVerificationCode.tr, 20,
                              AppColors.textPrimaryColor),
                          const SizedBox(
                            height: 25,
                          ),
                          Obx(() => onCommonTextFormField(LocaleKeys.smsSent.trParams({"number": controller.phoneNumber.value}),
                              16, AppColors.textSecondaryColor)),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: onGetEmailTextFormField(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Obx(() => controller.enableResend.value ?
                          GestureDetector(
                            onTap: (){
                              controller.onResendOTP();
                            },
                            child: onCommonTextFormField(LocaleKeys.resentOtp.tr, 14, AppColors.primaryColor),
                          ): onCommonTextFormField(LocaleKeys.resentOtpCount.trParams({"count":"${controller.secondsRemaining.value}s"}), 14, AppColors.disableColor))
                        ],)
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  color: AppColors.whiteColor,
                  child: onGetSignInButton()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget? desktop() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: Container(
          color: AppColors.appBarColor,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 3.5),
          child: CommonAppBar(
            title: LocaleKeys.forgetPass.tr,
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 3.5),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Form(
                  key: formKey,
                  child: AnimationLimiter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        SvgPicture.asset(
                          SVGPath.ForgotPassIcon,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        onCommonTextFormField(LocaleKeys.smsVerificationCode.tr, 20,
                            AppColors.textPrimaryColor),
                        const SizedBox(
                          height: 25,
                        ),
                        Obx(() => onCommonTextFormField(LocaleKeys.smsSent.trParams({"number": controller.phoneNumber.value}),
                            16, AppColors.textSecondaryColor)),
                        const SizedBox(
                          height: 30,
                        ),
                        onGetEmailTextFormField(),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(() => controller.enableResend.value ?
                        GestureDetector(
                          onTap: (){
                            controller.onResendOTP();
                          },
                          child: onCommonTextFormField(LocaleKeys.resentOtp.tr, 14, AppColors.primaryColor),
                        ): onCommonTextFormField(LocaleKeys.resentOtpCount.trParams({"count":"${controller.secondsRemaining.value}s"}), 14, AppColors.disableColor))
                      ],)
                    ),
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    children: [
                      onGetSignInButton(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        child: Container(),
                      )
                    ],
                  )),
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
            // color: AppColors.textPrimaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetEmailTextFormField() {
    return CustomTextFormField(
      editController: controller.otpCon,
      focusNode: controller.focusEmail,
      labelText: LocaleKeys.otp.tr,
      textInputType: TextInputType.number,
      maxLength: 6,
      onChange: (value) {
        controller.otp.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.otpValidator(value);
      },
    );
  }

  onGetSignInButton() {
    return Obx(
      () => CommonButton(
        buttonText: LocaleKeys.done.tr,
        width: Get.width,
        backgroundColor:
            Validator.otpValidator(controller.otp.value) == null
                ? AppColors.primaryColor
                : AppColors.disableColor,
        isBorder: false,
        textColor: Validator.otpValidator(controller.otp.value) == null
            ? AppColors.whiteColor
            : AppColors.disableTextColor,
        onTap: () {
          if (formKey.currentState!.validate()) {
            //Get.offNamed(RouteName.forgotPassWordEmailPage);
            controller.onVerifyOTP();
          }
        },
      ),
    );
  }
}
