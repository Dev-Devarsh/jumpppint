import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/updatepassword/domain/updatepassword_user_case.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class UpdatePasswordController extends SuperController {
  final ProgressController progressController;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final SharedPreferenceController sharedPreferenceController;

  UpdatePasswordController(this.progressController, this.updatePasswordUseCase,
      this.sharedPreferenceController);

  final TextEditingController editOldPass = TextEditingController();
  final TextEditingController editNewPass = TextEditingController();
  final TextEditingController editConfirmNewPass = TextEditingController();

  final RxString oldPassStr = "".obs;
  final RxString newPassStr = "".obs;
  final RxString confirmPassStr = "".obs;

  final FocusNode focusOldPass = FocusNode();
  final FocusNode focusNewPass = FocusNode();
  final FocusNode focusConfirmNewPass = FocusNode();

  @override
  void onInit() async {
    // TODO: implement onInit
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

  void getPatchResetPassword() {
    updatePasswordUseCase.getPatchResetPassword(newPassStr.value).then((value) {
      if (value != null) {
        print("getPatchResetPassword---------${value.result}");
        Get.back();
      } else {
        print("object");
      }
    });
  }

}
