import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/routes/all_routes.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../domain/batch_create_use_case.dart';

class BatchCreateController extends SuperController {
  final ProgressController progressController;
  final BatchCreateUseCase batchCreateUseCase;
  final SharedPreferenceController sharedPreferenceController;

  BatchCreateController(this.progressController, this.batchCreateUseCase,
      this.sharedPreferenceController);

  final TextEditingController editConSearch = TextEditingController();

  final TextEditingController editConCreated = TextEditingController();
  final TextEditingController editConCollected = TextEditingController();
  final TextEditingController editConShipping = TextEditingController();
  final TextEditingController editConCompleted = TextEditingController();
  final TextEditingController editConFrom = TextEditingController();
  final TextEditingController editConTo = TextEditingController();
  final TextEditingController editConSRRegion = TextEditingController();
  final TextEditingController editConSRArea = TextEditingController();
  final TextEditingController editConRRRegion = TextEditingController();
  final TextEditingController editConRRArea = TextEditingController();

  final FocusNode focusSearch = FocusNode();

  final FocusNode focusCreated = FocusNode();
  final FocusNode focusCollected = FocusNode();
  final FocusNode focusShipping = FocusNode();
  final FocusNode focusCompleted = FocusNode();
  final FocusNode focusFrom = FocusNode();
  final FocusNode focusTo = FocusNode();
  final FocusNode focusSRRegion = FocusNode();
  final FocusNode focusSRArea = FocusNode();
  final FocusNode focusRRRegion = FocusNode();
  final FocusNode focusRRArea = FocusNode();

  final isSearch = true.obs;

  // Preview Screen
  final TextEditingController editConEmail = TextEditingController();

  final FocusNode focusEmail = FocusNode();

  bool checkValidation() {
    return true;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isSearch.value = true;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
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
    batchCreateUseCase.logout().then((value) {
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
