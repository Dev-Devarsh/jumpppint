import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/model/shipment_status.dart';
import 'package:jumppoint_app/ui/home/model/shipment_record_list_model.dart';
import 'package:jumppoint_app/ui/shipment_tracking/domain/shipment_tracking_use_case.dart';
import 'package:jumppoint_app/ui/shipment_tracking/model/area_rank_response.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/routes/all_routes.dart';
import 'package:jumppoint_app/utills/utils.dart';

class ShipmentTrackingController extends SuperController {
  final ProgressController progressController;
  final ShipmentTrackingUseCase shipmentTrackingUseCase;
  final SharedPreferenceController sharedPreferenceController;
  final shipmentRecordListData = <ShipmentRecordData?>[].obs;
  static Rx<ShipmentStatus?> shipmentStatus = Rx<ShipmentStatus?>(null);
  final areaRanksList = <AreaRanks>[].obs;

  Rx<AreaRanks?> sendingRegion = Rx<AreaRanks?>(null);
  Rx<AreaRanks?> receivingRegion = Rx<AreaRanks?>(null);

  Rx<Areas?> sendingAreas = Rx<Areas?>(null);
  Rx<Areas?> receivingAreas = Rx<Areas?>(null);

  ShipmentTrackingController(this.progressController,
      this.shipmentTrackingUseCase, this.sharedPreferenceController);

  final TextEditingController editConSearch = TextEditingController();

  final TextEditingController editConFrom = TextEditingController();
  final TextEditingController editConTo = TextEditingController();
  final selectedFromDate = DateTime(1900).obs;
  final selectedToDate = DateTime(1900).obs;

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

  RxBool isFromFilled = false.obs;
  RxBool isToSelected = false.obs;

  // final DropdownEditingController fromController = DropdownEditingController();

  // final DropdownEditingController toController = DropdownEditingController();

  final DropdownEditingController regionController =
      DropdownEditingController();

  final DropdownEditingController areaController = DropdownEditingController();

  final List<Map<String, dynamic>> RAList = [
    {"name": "ABC", "index": 1},
    {"name": "ABC", "index": 2},
    {"name": "ABC", "index": 3},
    {"name": "ABC", "index": 4},
    {"name": "ABC", "index": 5},
  ];

  final List<Map<String, dynamic>> roles = [
    {
      "name": "2022-03-21 (Mon)",
      "desc": "Having full access rights",
      "role": 1
    },
    {
      "name": "2022-03-22 (Tue)",
      "desc": "Having full access rights of a Organization",
      "role": 2
    },
    {
      "name": "2022-03-23 (Wed)",
      "desc": "Having Magenent access rights of a Organization",
      "role": 3
    },
    {
      "name": "2022-03-24 (Thu)",
      "desc": "Having Technician Support access rights",
      "role": 4
    },
    {
      "name": "2022-03-25 (Fri)",
      "desc": "Having Customer Support access rights",
      "role": 5
    },
    {
      "name": "2022-03-26 (Sat)",
      "desc": "Having End User access rights",
      "role": 6
    },
  ];

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getShipmentRecordList();
    getShipmentStatusSummary();
    getRegion();
    isSearch.value = true;
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
    shipmentTrackingUseCase.logout().then((value) {
      if (value != null) {
        if (value.isSuccess) {
          Get.back();
          Get.offAllNamed(
            RouteName.root,
          );
          sharedPreferenceController.logout();
        }
        Utils.showSnackbar(value.message ?? []);
      }
    });
  }

  void getShipmentRecordList({bool isFilter = false}) {
    String shipmentStates = "";
    if(isFilter){
      shipmentStates = ShipmentTrackingController.shipmentStatus.value!.summary!.where((i) => i.isCheck == true).toList().map((e) => e.shipmentState).toList().join(",");
    }
    Map<String, dynamic> shipmentRecordListParams = {
      // "limit": "20079405.850656465","offset": "20079405.850656465"
      // "limit": "6","offset": "1",
      "searchTracking": editConSearch.text.toString(),
      // "searchExtNumber":"",
      "shipmentStates": shipmentStates,
      "dateFrom": editConFrom.text.toString(),
      "dateTo": editConTo.text.toString(),
      "originAreaRank": sendingAreas.value?.en,
      "destinationAreaRank": receivingAreas.value?.en
    };
    shipmentTrackingUseCase
        .getShipmentRecordList(shipmentRecordListParams)
        .then((value) {
      shipmentRecordListData.value = [];
      if (value != null) {
        value.forEach((v) {
          shipmentRecordListData.add(ShipmentRecordData.fromJson(v));
        });

        if (isFilter) {
          Get.back();
        }
        shipmentRecordListData.forEach((element) {
          element!.createdAtOld = Utils.apiDateFormatByDate(element.createdAt!);
        });
      }
    });
  }

  void getShipmentStatusSummary() {
    shipmentTrackingUseCase.getShipmentStatusSummary().then((value) {
      print("result===>>>getShipmentStatusSummary ${value}");
      if (value != null) {
        shipmentStatus.value = ShipmentStatus.fromJson(value.result);
      }
    });
  }

  void getRegion() {
    shipmentTrackingUseCase.getAreaRankList().then((value) {
      if (value != null) {
        AreaRankResponse response = AreaRankResponse.fromMap(value.result);
        areaRanksList.value = response.areaRanks;
      }
    });
  }
}
