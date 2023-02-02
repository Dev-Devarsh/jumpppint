import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/domain/confirm_shipment_use_case.dart';
import 'package:jumppoint_app/ui/confirm_shipment/shipment_preview/domain/shipment_preview_use_case.dart';
import 'package:jumppoint_app/utills/colors.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ConfirmShipmentPreviewController extends SuperController {
  final ProgressController progressController;
  final ConfirmShipmentPreviewUseCase confirmShipmentPreviewUseCase;
  final SharedPreferenceController sharedPreferenceController;

  ConfirmShipmentPreviewController(this.progressController, this.confirmShipmentPreviewUseCase,
      this.sharedPreferenceController);





  @override
  void onInit() async {
    super.onInit();

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