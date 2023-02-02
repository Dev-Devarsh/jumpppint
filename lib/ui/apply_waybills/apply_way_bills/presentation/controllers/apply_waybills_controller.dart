import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/apply_waybills/model/label_request_item.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/routes/all_routes.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../domain/apply_waybills_use_case.dart';

class ApplyWayBillsController extends SuperController {
  final ProgressController progressController;
  final ApplyWayBillsUseCase applyWayBillsUseCase;
  final SharedPreferenceController sharedPreferenceController;

  ApplyWayBillsController(this.progressController, this.applyWayBillsUseCase,
      this.sharedPreferenceController);

  final editStandardDelivery = TextEditingController().obs;
  final editExpressDelivery = TextEditingController().obs;
  final editAddress = TextEditingController().obs;
  final editConRemarks = TextEditingController().obs;

  final nameCon = TextEditingController().obs;
  final mobileNoCon = TextEditingController().obs;
  final regionCodeCon = TextEditingController().obs;
  final flatOrRoomCon = TextEditingController().obs;
  final floorCon = TextEditingController().obs;
  final buildingOrStreetNoCon = TextEditingController().obs;

  LabelRequestItem labelRequestItem =
      LabelRequestItem(createAddress: CreateAddress(address: Address()));

  final RxString standardDelivery = "".obs;
  final RxString expressDelivery = "".obs;

  // final RxString address="".obs;
  final RxString remarks = "".obs;
  final RxString name = "".obs;
  final RxString regionCode = "".obs;
  final RxString mobileNumber = "".obs;
  final RxString flatOrRoom = "".obs;
  final RxString floor = "".obs;
  final RxString buildingOrStreetNo = "".obs;

  RxInt charLengthName = 0.obs;
  RxInt charLengthFlat = 0.obs;
  RxInt charLengthFloor = 0.obs;

  final FocusNode focusStandard = FocusNode();
  final FocusNode focusExpressDelivery = FocusNode();
  final FocusNode focusAddress = FocusNode();
  final FocusNode focusRemarks = FocusNode();

  final FocusNode focusSenderNam = FocusNode();
  final FocusNode focusMobileNo = FocusNode();
  final FocusNode focusRegionCode = FocusNode();
  final FocusNode focusFlatOrRoom = FocusNode();
  final FocusNode focusFloor = FocusNode();
  final FocusNode focusbuildingOrStreetNo = FocusNode();
  final FocusNode focusEnterAddress = FocusNode();

  final TextEditingController editConSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();

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

  void doLabelRequest() {
    applyWayBillsUseCase.doLabelRequest(labelRequestItem).then((value) {
      if (value != null) {
        print("doLabelRequest---------${value}");
        editStandardDelivery.value.text = "";
        editExpressDelivery.value.text = "";
        editConRemarks.value.text = "";
        nameCon.value.text = "";
        mobileNoCon.value.text = "";
        regionCodeCon.value.text = "";
        flatOrRoomCon.value.text = "";
        floorCon.value.text = "";
        buildingOrStreetNoCon.value.text = "";
        labelRequestItem =
            LabelRequestItem(createAddress: CreateAddress(address: Address()));
      } else {
        print("object");
      }
    });
  }

  logout() {
    applyWayBillsUseCase.logout().then((value) {
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
}
