import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/model/shipment_details.dart';
import 'package:jumppoint_app/ui/order_details/domain/order_detail_user_case.dart';
import 'package:jumppoint_app/utills/download.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:universal_html/html.dart';

class OrderDetailsController extends SuperController
    with GetSingleTickerProviderStateMixin {
  final ProgressController progressController;
  final OrderDetailsUseCase orderDetailsUseCase;
  final SharedPreferenceController sharedPreferenceController;

  OrderDetailsController(this.progressController, this.orderDetailsUseCase,
      this.sharedPreferenceController);

  final TextEditingController editConSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();
  Rx<ShipmentDetails?> shipmentDetails = Rx<ShipmentDetails?>(null);

  late TabController tabController;

  final DropdownEditingController fromController = DropdownEditingController();

  final DropdownEditingController toController = DropdownEditingController();

  RxBool isFromFilled = false.obs;
  RxBool isToSelected = false.obs;
  String lanCode = "";

  RxBool isSearch = true.obs;
  RxBool isSearching = false.obs;
  RxBool isDetailTab = true.obs;
  RxBool showUi = false.obs;
  RxBool isSearchVisible = true.obs;
  final trackingNumber = "".obs;

  final RxString waybillsRecord = "".obs;

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
    super.onInit();
    getOrderDetails();
    tabController = TabController(
        length: 2, vsync: this, animationDuration: Duration(milliseconds: 700));
    lanCode =
        await sharedPreferenceController.getNormal(PrefKeys.keyLanguageCode) ??
            "";
    if (Get.arguments != null) {
      trackingNumber.value = Get.arguments["trackingNumber"];
    }
  }

  @override
  void onReady() async {
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

  void getOrderDetails({String? searchText}) {
    orderDetailsUseCase.getOrderDetails(searchText).then((value) {
      print("result===>>>getOrderDetails ${value}");
      if (value != null) {
        shipmentDetails.value = ShipmentDetails.fromJson(value.result);
        showUi = true.obs;
      }
    });
  }

  void downloadWayBills() {
    orderDetailsUseCase.getShipmentLabel(trackingNumber.value).then((value) {
      if (value != null) {
        print("result===>>>getShipmentLabel ${value.result}");
        waybillsRecord.value = value.result['labelUrl'];
        print("waybillsRecord-- ${waybillsRecord.value}");
        if(kIsWeb){
          AnchorElement anchorElement = AnchorElement(href: "Download/${waybillsRecord.value}");
          anchorElement.download = "waybill.pdf";
          anchorElement.click();
          print("object ${anchorElement}");
        }else{
          Download.requestFilePermission(waybillsRecord.value, filename: "waybill.pdf");
        }
      }
    });
  }
}
