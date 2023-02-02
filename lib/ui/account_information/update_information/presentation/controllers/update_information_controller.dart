import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jumppoint_app/model/user_info.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';
import '../../../account_information/domain/account_information_use_case.dart';

class UpdateInformationController extends SuperController {
  final ProgressController progressController;
  final AccountInformationUseCase accountInformationUseCase;
  final SharedPreferenceController sharedPreferenceController;

  UpdateInformationController(this.progressController,
      this.accountInformationUseCase, this.sharedPreferenceController);

  final TextEditingController firstNameCon = TextEditingController();
  final FocusNode focusFirstName = FocusNode();
  final FocusNode focusEmail = FocusNode();

  Rx<UserData?> userData = Rx<UserData?>(null);

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      userData.value = Get.arguments["userData"];

      firstNameCon.text = userData.value?.name??"";
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
    // TODO: implement onResumed
  }

  void updateInfo() {
    Map<String, dynamic> updateData = {
      "name": firstNameCon.text,
    };
    accountInformationUseCase.updateAccountInfo(updateData).then((value) {
      if (value != null) {
        userData.value = UserData.fromJson(value.result);
        Get.back();
      }
    });
  }
}
