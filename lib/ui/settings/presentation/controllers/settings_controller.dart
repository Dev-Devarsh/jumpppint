import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/settings/domain/settings_use_case.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/routes/all_routes.dart';
import 'package:jumppoint_app/utills/utils.dart';

class SettingsController extends SuperController {
  final ProgressController progressController;
  final SettingsUseCase settingsExportUseCase;
  final SharedPreferenceController sharedPreferenceController;

  SettingsController(this.progressController, this.settingsExportUseCase,
      this.sharedPreferenceController);

  final TextEditingController editConEmail = TextEditingController();

  final FocusNode focusEmail = FocusNode();


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

  void logout() {
    settingsExportUseCase.logout().then((value) {
      if (value != null) {
        if (value.isSuccess) {
          Get.back();
          Get.offAllNamed(RouteName.root,);
          sharedPreferenceController.logout();
        }
        Utils.showSnackbar(value.message??[]);
      }
    });
  }
}
