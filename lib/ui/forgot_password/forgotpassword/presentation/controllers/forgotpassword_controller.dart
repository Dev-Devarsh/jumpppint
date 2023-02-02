import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

import '../../domain/forgotpassword_user_case.dart';

class ForgotPasswordController extends SuperController {
  final ProgressController progressController;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final SharedPreferenceController sharedPreferenceController;

  ForgotPasswordController(this.progressController, this.forgotPasswordUseCase,
      this.sharedPreferenceController);

  // Forgot password Page - Email Screen
  final TextEditingController otpCon = TextEditingController();
  final FocusNode focusEmail = FocusNode();
  final RxString email="".obs;
  final RxString phoneNumber="".obs;
  final RxString otp="".obs;

  final secondsRemaining = 60.obs;
  Timer? countdownTimer;
  final enableResend = true.obs;

  // Forgot Password Page - Enter New Password

  final TextEditingController editNewPass = TextEditingController();
  final TextEditingController editResetPass = TextEditingController();

  final FocusNode focusNewPass = FocusNode();
  final FocusNode focusResetPass = FocusNode();

  final accessToken= "".obs;

  @override
  void onInit() async {
    if(Get.arguments != null){
      if(Get.arguments["from"] !=  null && Get.arguments["from"] == "forgotPassword"){
        accessToken.value = Get.arguments["accessToken"];
      }else{
        email.value = Get.arguments["email"];
        phoneNumber.value = Get.arguments["phoneNumber"];
      }
    }
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() async {
    // TODO: implement onResumed
  }

  void onResendOTP() {
    forgotPasswordUseCase.doInitOtp(email.value)
        .then((value) {
      print("ValueL>Login===>> ${value!['phone']}");
      if (value != null) {
        secondsRemaining.value = 60;
        enableResend.value = false;
        countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          print("object==>>> ${secondsRemaining.value}");
          if(secondsRemaining.value == 0){
            enableResend.value = true;
            countdownTimer?.cancel();
          }else{
            secondsRemaining.value--;
          }
        });
      }
    });
  }

  void onVerifyOTP() {
    forgotPasswordUseCase.doVerifyOtp(email.value,otp.value)
        .then((value) {
      if (value != null) {
        Get.offNamed(RouteName.newPassWordPage,arguments: {"accessToken":value['access_token'],"from":"forgotPassword"});
      }
    });
  }

  void onChangePassword() {
    forgotPasswordUseCase.doChangePassword(editNewPass.text,accessToken.value)
        .then((value) {
      if (value != null) {
        if(value['result'] == 'Success'){
          Get.offAllNamed(RouteName.root);
        }
      }
    });
  }
}
