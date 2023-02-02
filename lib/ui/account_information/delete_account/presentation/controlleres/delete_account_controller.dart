import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jumppoint_app/model/user_info.dart';
import 'package:jumppoint_app/routes.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';
import '../../domain/delete_account_use_case.dart';

class DeleteAccountController extends SuperController {
  final ProgressController progressController;
  final DeleteAccountUseCase deleteAccountUseCase;
  final SharedPreferenceController sharedPreferenceController;

  DeleteAccountController(this.progressController, this.deleteAccountUseCase,
      this.sharedPreferenceController);

  final TextEditingController accountBenefitiaryName = TextEditingController();
  final TextEditingController bankNumber = TextEditingController();

  final DropdownEditingController bankNameController =
      DropdownEditingController();

  RxBool isBankNameFilled = false.obs;

  Rx<UserData?> userData = Rx<UserData?>(null);

  final FocusNode focusAccountBenefitiaryName = FocusNode();
  final FocusNode focusbankNumber = FocusNode();

  final List<Map<String, dynamic>> names = [
    {"name": "XXXXXX Bank Name"},
    {"name": "XXXXXX Bank Name"},
    {"name": "XXXXXX Bank Name"},
    {"name": "XXXXXX Bank Name"},
    {"name": "XXXXXX Bank Name"},
    {"name": "XXXXXX Bank Name"},
  ];

  void goToSadToLeaveView() {
    Get.toNamed(RouteName.sadTOLeaveScreen,arguments: {"userData":userData.value});
  }

  void backToHome() {
    Get.toNamed(RouteName.homePage);
  }

  @override
  void onInit() async {
    super.onInit();
    if(Get.arguments != null){
      userData.value = Get.arguments["userData"];
    }
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
  }

  void deleteAccount() {
    deleteAccountUseCase.doDeleteAccount(
      accountBenefitiaryName.value.text.trim(),
      bankNumber.value.text.trim(),
      "Bank Name",
    )
        .then((value) {
      if (value != null) {
        goToSadToLeaveView();
      }
    });
  }
}
