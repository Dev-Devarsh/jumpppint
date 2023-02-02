import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/pickup_points/domain/pickup_point_use_case.dart';
import 'package:jumppoint_app/ui/pickup_points/model/pickup_points_model.dart';
import 'package:jumppoint_app/utills/routes/all_routes.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class PickupPointsController extends SuperController {
  final ProgressController progressController;
  final PickupPointsUseCase pickupPointsUseCase;
  final SharedPreferenceController sharedPreferenceController;

  PickupPointsController(this.progressController, this.pickupPointsUseCase,
      this.sharedPreferenceController);

  RxList<PickupPointsModel> pickupPointList = <PickupPointsModel>[].obs;

  final TextEditingController editConSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();
  final isSearch = true.obs;




  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    onGetNotificationRecords();
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

  void onGetNotificationRecords() {
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: true,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: true,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: true,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );

    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
    pickupPointList.add(
      PickupPointsModel(
        pickupPointsNo: "KLE47",
        pickupPointsTitle: "新蒲崗自提點",
        pickupPointsAddress: "新蒲崗大有街31號善美工業大廈10樓1001室",
        isRead: false,
      ),
    );
  }

  void logout() {
    pickupPointsUseCase.logout().then((value) {
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
