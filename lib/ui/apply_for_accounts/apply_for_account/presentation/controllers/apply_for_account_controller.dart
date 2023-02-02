import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';
import '../../domain/apply_for_account_use_case.dart';

class ApplyForAccountController extends SuperController {
  final ProgressController progressController;
  final ApplyForAccountUseCase applyForAccountUseCase;
  final SharedPreferenceController sharedPreferenceController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ApplyForAccountController(this.progressController,
      this.applyForAccountUseCase, this.sharedPreferenceController);

  TextEditingController editConEmail = TextEditingController();
  TextEditingController editConName = TextEditingController();
  TextEditingController editConAreaCode = TextEditingController();
  TextEditingController editConMobile = TextEditingController();
  TextEditingController editConCompanyName = TextEditingController();
  TextEditingController editConRemarks = TextEditingController();

  FocusNode focusEmail = FocusNode();
  FocusNode focusName = FocusNode();
  FocusNode focusAreaCode = FocusNode();
  FocusNode focusMobile = FocusNode();
  FocusNode focusCompanyName = FocusNode();
  FocusNode focusRemarks = FocusNode();

  RxString email = "".obs;
  RxString name = "".obs;
  RxString areaCode = "".obs;
  RxString mobile = "".obs;
  RxString companyName = "".obs;
  RxString remarks = "".obs;
  RxBool knowUs = false.obs;
  RxBool knowUsError = true.obs;

  final RxString onNext = "".obs;

  DropdownEditingController knowUsController = DropdownEditingController();

  // Apply For Account Password

  final TextEditingController editConPassword = TextEditingController();
  final TextEditingController editConConfirmPassword = TextEditingController();

  final FocusNode focusPassword = FocusNode();
  final FocusNode focusConfirmPassword = FocusNode();

  RxString password = "".obs;
  RxString confirmPassword = "".obs;

  // Apply Account for SMS

  bool onDropDownValueCheck() {
    if (knowUs.value == false) {
      knowUsError.value = false;
      return false;
    }
    return true;
  }

  void clearFocus() {
    Get.focusScope!.unfocus();
  }

  @override
  void onInit() async {
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
  void onResumed() {
    // TODO: implement onResumed
  }

  void onGetRegister() {
    applyForAccountUseCase
        .doRegister(
      editConEmail.value.text.trim(),
      confirmPassword.value.trim(),
      "ADVERTISMENT",
      editConCompanyName.value.text.trim(),
      editConName.value.text.trim(),
      editConMobile.value.text.trim(),
      editConRemarks.value.text.trim(),
    )
        .then((value) {
      print("ValueL>Register===>> ${value}");
      if (value != null) {
        print("userId---------${value["userId"]}");
        print("phone---------${value["phone"]}");
        Get.toNamed(RouteName.smsVerification,
            arguments: {'userId': value["userId"], 'phone': value["phone"]});
      } else {
        print("object");
      }
    });
  }

}
