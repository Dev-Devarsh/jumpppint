import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/smsVerification/domain/sms_verification_user_case.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class SmsVerificationController extends SuperController {
  final ProgressController progressController;
  final SmsVerificationUseCase smsVerificationUseCase;
  final SharedPreferenceController sharedPreferenceController;

  SmsVerificationController(this.progressController, this.smsVerificationUseCase,
      this.sharedPreferenceController);


  final TextEditingController editConOTP = TextEditingController();

  final FocusNode focusOTP = FocusNode();

  RxString otp = "".obs;
  final userId = "".obs;
  final phone = "".obs;


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments != null) {
      userId.value = Get.arguments["userId"];
      phone.value = Get.arguments["phone"];
      print("userId.value=========${userId.value}");
      print("phone.value=========${phone.value}");
    }
    onGetOtp();
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

  void onGetOtp() {
    smsVerificationUseCase
        .doInitOtp(userId.value)
        .then((value) {
      print("ValueL>Otp===>> $value");
      if (value != null) {
        print("userId---------${value['userId']}");
      } else {
        print("object");
      }
    });
  }

  void onGetVerifyOtp() {
    smsVerificationUseCase
        .doVerifyOtp(otp.value.toString().trim(),userId.value)
        .then((value) {
      print("ValueL>OtpVerify===>> $value");
      if (value != null) {
        print("otp---------${value['otp']}");
        print("userId---------${value['userId']}");
        Get.toNamed(RouteName.applyForAccountDone);
      } else {
        print("object");
      }
    });
  }
}
