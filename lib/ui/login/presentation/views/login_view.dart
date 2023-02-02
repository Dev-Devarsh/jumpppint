import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/template.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetResponsiveView<LoginController> {
  final AppThemeState _appTheme = AppThemeState();
  final formKey = GlobalKey<FormState>();
  var isForgotClick = false;

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
    return Template(
        body: Form(
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
            Image.asset(
              PNGPath.loginLogo,
              width: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            onGetEmailTextFormField(),
            const SizedBox(
              height: 15,
            ),
            onGetPasswordTextFormField(),
            const SizedBox(
              height: 5,
            ),
            onGetForgotPassword(),
            const SizedBox(
              height: 45,
            ),
            onGetSignInButton(),
            const SizedBox(
              height: 15,
            ),
            onGetSignUpButton(),
            const SizedBox(
              height: 25,
            ),
            onGetTerms(),
            const SizedBox(
              height: 5,
            ),
            onGetTermsAndCondition()
          ],
        ),
      )),
    ));
  }

  @override
  Widget? tablet() {
    return Template(
        body: Form(
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
            Image.asset(
              PNGPath.loginLogo,
              width: 150,
            ),
            const SizedBox(
              height: 50,
            ),
            onGetEmailTextFormField(),
            const SizedBox(
              height: 15,
            ),
            onGetPasswordTextFormField(),
            const SizedBox(
              height: 5,
            ),
            onGetForgotPassword(),
            const SizedBox(
              height: 45,
            ),
            onGetSignInButton(),
            const SizedBox(
              height: 15,
            ),
            onGetSignUpButton(),
            const SizedBox(
              height: 25,
            ),
            onGetTerms(),
            const SizedBox(
              height: 5,
            ),
            onGetTermsAndCondition()
          ],
        ),
      )),
    ));
  }

  @override
  Widget? desktop() {
    print("TempLate");
    return Template(
        body: Align(
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        width: Get.width * 0.3,
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
                Image.asset(
                  PNGPath.loginLogo,
                  width: 150,
                ),
                const SizedBox(
                  height: 50,
                ),
                onGetEmailTextFormField(),
                const SizedBox(
                  height: 15,
                ),
                onGetPasswordTextFormField(),
                const SizedBox(
                  height: 5,
                ),
                onGetForgotPassword(),
                const SizedBox(
                  height: 45,
                ),
                onGetSignInButton(),
                const SizedBox(
                  height: 15,
                ),
                onGetSignUpButton(),
                const SizedBox(
                  height: 25,
                ),
                onGetTerms(),
                const SizedBox(
                  height: 5,
                ),
                onGetTermsAndCondition()
              ],
            ),
          )),
        ),
      ),
    ));
  }

  onGetEmailTextFormField() {
    return CustomTextFormField(
      editController: controller.editConEmail,
      focusNode: controller.focusEmail,
      labelText: LocaleKeys.emailLabel.tr,
      textInputType: TextInputType.emailAddress,
      onChange: (value) {},
      onValidate: (value) {
        return Validator.emailValidator(value);
      },
    );
  }

  onGetPasswordTextFormField() {
    return CustomTextFormField(
      editController: controller.editConPassword,
      focusNode: controller.focusPassword,
      labelText: LocaleKeys.passwordLabel.tr,
      isDenySpaces: true,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      isPassword: true,
      onChange: (value) {},
      onValidate: (value) {
        if(!isForgotClick) {
          return Validator.passwordValidator(value);
        }
      },
    );
  }

  onGetForgotPassword() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: InkWell(
        onTap: () {
          isForgotClick = true;
          if (formKey.currentState!.validate()) {
            controller.initOTP();
            // Get.toNamed(RouteName.forgotPassWordPage);
          }
        },
        child: Text(
          LocaleKeys.forgotLabel.tr,
          style: _appTheme.customTextStyle(
              fontSize: 12,
              color: AppColors.primaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ),
    );
  }

  onGetSignInButton() {
    return CommonButton(
      buttonText: LocaleKeys.btnSignIn.tr,
      width: Get.width,
      backgroundColor: AppColors.primaryColor,
      isBorder: false,
      textColor: AppColors.whiteColor,
      onTap: () {
        if (formKey.currentState!.validate()) {
          Logger.dev("@149 Login Button Tap");
          controller.onGetLogin();
          // Get.offNamed(RouteName.homePage);
        }
      },
    );
  }

  onGetSignUpButton() {
    return CommonButton(
      buttonText: LocaleKeys.btnSignUp.tr,
      width: Get.width,
      isBorder: true,
      borderColor: AppColors.primaryColor,
      textColor: AppColors.primaryColor,
      onTap: () {
        Get.toNamed(RouteName.applyForAccount);
        // Logger.dev("Signup Button Tap");
      },
    );
  }

  onGetTerms() {
    return Align(
      alignment: AlignmentDirectional.center,
      child: Text(
        LocaleKeys.termsAndCondition.tr,
        style: _appTheme.customTextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryColor,
            fontWeightType: FWT.regular,
            fontFamilyType: FFT.nunito),
      ),
    );
  }

  onGetTermsAndCondition() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: LocaleKeys.privacyPolicy.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          TextSpan(
            text: " ${LocaleKeys.and.tr} ",
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.textSecondaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
          TextSpan(
            text: LocaleKeys.termsServices.tr,
            style: _appTheme.customTextStyle(
                fontSize: 12,
                color: AppColors.primaryColor,
                fontWeightType: FWT.regular,
                fontFamilyType: FFT.nunito),
          ),
        ],
      ),
    );
  }
}
