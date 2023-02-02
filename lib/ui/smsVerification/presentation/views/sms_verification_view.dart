import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/common/common_app_bar.dart';
import 'package:jumppoint_app/ui/smsVerification/presentation/controllers/sms_verification_controller.dart';
import 'package:jumppoint_app/utills/asset_images.dart';
import 'package:jumppoint_app/utills/enum/font_type.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/logger/logger.dart';
import 'package:jumppoint_app/utills/validator.dart';

import '../../../../utills/app_theme.dart';
import '../../../../utills/colors.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_textformfield.dart';

class SmsVerificationView extends GetResponsiveView<SmsVerificationController> {
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
          title: LocaleKeys.smsTitle.tr,
          elevation: 0.0,
          isBackButtonVisible: true,
          leadingWidth: 50,
          centerTitle: true,
        ),
      ),
      body: Obx(() => SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            color: AppColors.backgroundColor,
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    SVGPath.smsVerification,
                                    width: 100,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  onCommonTextFormField(
                                      LocaleKeys.smsVerificationCode.tr,
                                      20,
                                      AppColors.textPrimaryColor),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  onCommonTextFormField(LocaleKeys.smsSent.tr,
                                      16, AppColors.textSecondaryColor),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: onGetOTPTextFormField(),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  onCommonTextFormField(LocaleKeys.resentOtp.tr,
                                      14, AppColors.primaryColor),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    color: AppColors.whiteColor, child: onGetDoneButton()),
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 50),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width/3.1),
          color: AppColors.primaryColor,
          child: CommonAppBar(
            title: LocaleKeys.smsTitle.tr,
            elevation: 0.0,
            isBackButtonVisible: true,
            leadingWidth: 50,
            centerTitle: true,
          ),
        ),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          width: Get.width / 3,
                          color: AppColors.backgroundColor,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  SVGPath.smsVerification,
                                  width: 100,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                onCommonTextFormField(
                                    LocaleKeys.smsVerificationCode.tr,
                                    20,
                                    AppColors.textPrimaryColor),
                                const SizedBox(
                                  height: 25,
                                ),
                                onCommonTextFormField(LocaleKeys.smsSent.tr, 16,
                                    AppColors.textSecondaryColor),
                                const SizedBox(
                                  height: 30,
                                ),
                                onGetOTPTextFormField(),
                                const SizedBox(
                                  height: 25,
                                ),
                                InkWell(
                                  onTap: (){},
                                  child:
                                  Text(
                                    LocaleKeys.resentOtp.tr,
                                    textAlign: TextAlign.center,
                                    style: AppThemeState().customTextStyle(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                        fontWeightType: FWT.regular,
                                        fontFamilyType: FFT.nunito),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  // padding:
                  //     const EdgeInsets.symmetric(vertical: 8, horizontal: 450),
                  // child: onGetDoneButton()),
                  child: Column(
                    children: [
                      onGetDoneButton(),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        child: Container(),
                      )
                    ],
                  )),
            ],
          )),
    );
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
              // color: AppColors.textPrimaryColor,
              fontWeightType: FWT.regular,
              fontFamilyType: FFT.nunito),
        ),
      ),
    );
  }

  onGetOTPTextFormField() {
    return CustomTextFormField(
      editController: controller.editConOTP,
      focusNode: controller.focusOTP,
      labelText: LocaleKeys.otp.tr,
      // textInputType: TextInputType.number,
      textInputType: const TextInputType.numberWithOptions(signed: true),
      onChange: (value) {
        controller.otp.value = value ?? '';
      },
      onValidate: (value) {
        return Validator.smsOtpValidator(value);
      },
    );
  }

  onGetDoneButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, top: 10, left: 15, right: 15),
      child: CommonButton(
        buttonText: LocaleKeys.done.tr,
        width: screen.isDesktop ? Get.width / 3 : Get.width,
        backgroundColor:
            controller.otp.value.isNotEmpty && formKey.currentState!.validate()
                ? AppColors.primaryColor
                : AppColors.disableColor,
        textColor:
            controller.otp.value.isNotEmpty && formKey.currentState!.validate()
                ? AppColors.whiteColor
                : AppColors.lightGreyColor,
        isBorder: false,
        onTap: () {
          if (controller.otp.value.isNotEmpty &&
              formKey.currentState!.validate()) {
            Get.toNamed(RouteName.applyForAccountDone);
            controller.onGetVerifyOtp();
          } else {
            Logger.dev("Done Validate Failed");
          }
        },
      ),
    );
  }

}
