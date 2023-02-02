import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/shipmentDone/domain/shipment_done_use_case.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ShipmentDoneController extends SuperController {
  final ProgressController progressController;
  final ShipmentDoneUseCase shipmentDoneUseCase;
  final SharedPreferenceController sharedPreferenceController;

  ShipmentDoneController(this.progressController, this.shipmentDoneUseCase,
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
}
