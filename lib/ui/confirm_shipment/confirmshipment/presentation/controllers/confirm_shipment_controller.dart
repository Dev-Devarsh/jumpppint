import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/domain/confirm_shipment_use_case.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ConfirmShipmentController extends SuperController {
  final ProgressController progressController;
  final ConfirmShipmentUseCase confirmShipmentUseCase;
  final SharedPreferenceController sharedPreferenceController;

  ConfirmShipmentController(this.progressController, this.confirmShipmentUseCase,
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
        statusBarIconBrightness: Brightness.dark
    ));
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
}