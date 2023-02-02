import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/browsecargo/waybill/domain/waybill_use_case.dart';
import 'package:jumppoint_app/utills/download.dart';
import 'package:universal_html/html.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';

class WayBillController extends SuperController {

  final ProgressController progressController;
  final WayBillUseCase wayBillUseCase;
  final SharedPreferenceController sharedPreferenceController;

  WayBillController(this.progressController, this.wayBillUseCase,
      this.sharedPreferenceController);

  final RxString waybillsItemRecord = "".obs;

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

  void getItemLabel() {
    wayBillUseCase.getItemLabel("JP123456789").then((value) {
      if (value != null) {
        print("result===>>>getItemLabel ${value.result}");
        waybillsItemRecord.value = value.result['labelUrl'];
        print("waybillsItemRecord-- ${waybillsItemRecord.value}");
        if(kIsWeb){
          AnchorElement anchorElement = AnchorElement(href: "Download/${waybillsItemRecord.value}");
          anchorElement.download = "waybill_item.pdf";
          anchorElement.click();
          print("object ${anchorElement}");
        }else{
          Download.requestFilePermission(waybillsItemRecord.value, filename: "waybill_item.pdf");
        }
      }
    });
  }

}
