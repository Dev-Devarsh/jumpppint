import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/browsecargo/domain/browser_cargo_use_case.dart';
import 'package:jumppoint_app/ui/shipment_tracking/model/item_detail.dart';
import 'package:jumppoint_app/utills/download.dart';
import 'package:universal_html/html.dart';

import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class BrowseCargoController extends SuperController
    with GetSingleTickerProviderStateMixin {
  final ProgressController progressController;
  final BrowserCargoUseCase browserCargoUseCase;
  final SharedPreferenceController sharedPreferenceController;

  BrowseCargoController(this.progressController, this.browserCargoUseCase,
      this.sharedPreferenceController);

  late TabController tabController;

  final initialIndex = 0.obs;
  final itemId = "".obs;

  final RxString waybillsItemRecord = "".obs;

  RxList<StatusLogs> statusLogsList = <StatusLogs>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(Get.arguments !=null){
      initialIndex.value = Get.arguments["initialIndex"];
      itemId.value = Get.arguments["itemId"];
    }
    tabController = TabController(length: 2, vsync: this,initialIndex: initialIndex.value);
    getItemData();
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

  void getItemData() {
    browserCargoUseCase.getItemDetails(itemId.value).then((value) {
        if (value != null) {
          ItemDetailResponse response = ItemDetailResponse.fromMap(value.result);
          if(response.statusLogs.isNotEmpty){
            statusLogsList.addAll(response.statusLogs);
          }
        }
      });
  }

  void getItemLabel() {
    browserCargoUseCase.getItemLabel("JP123456789").then((value) {
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
