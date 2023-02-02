import 'dart:convert';

import 'package:get/get.dart';
import 'package:jumppoint_app/model/user_info.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/home/model/in_app_notice_model.dart';
import 'package:jumppoint_app/ui/home/model/shipment_record_list_model.dart';
import 'package:jumppoint_app/ui/home/model/shipment_status_model.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../../domain/home_user_case.dart';

class HomeController extends SuperController {
  final ProgressController progressController;
  final HomeUseCase homeUseCase;
  final SharedPreferenceController sharedPreferenceController;

  HomeController(this.progressController, this.homeUseCase,
      this.sharedPreferenceController);

  RxInt currentIndex = 0.obs;
  RxInt isNotice = 0.obs;
  Rx<UserData?> userData = Rx<UserData?>(null);
  final summary = <Summary?>[].obs;
  final totalCount = 0.obs;

  final inAppNoticeList = <InAppNotice>[].obs;

  final shipmentRecordListData = <ShipmentRecordData?>[].obs;

  @override
  void onInit() async {
    super.onInit();
    sharedPreferenceController.getToken(PrefKeys.token);
    getUserInfo();
    getShipmentStatus();
    getShipmentRecordList();
    getInAppNoticeById();
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

  void getUserInfo() {
    homeUseCase.getUserInfo().then((value) {
      if (value != null) {
        print("result===>>> ${value.toJson()}");
        userData.value = UserData.fromJson(value.result);
      }
    });
  }

  void getShipmentStatus() {
    homeUseCase.getShipmentStatus().then((value) {
      if (value != null) {
        print("result===>>> ${value.toJson()}");
        value.result['summary'].forEach((v) {
          summary.add(Summary.fromJson(v));
        });
        print("result===>>> ${summary.length}");
        for (var i = 0; i < summary.length; i++) {
          totalCount.value += summary[i]?.count ?? 0;
        }
        print("totalCount.value===>>> ${totalCount.value}");
      }
    });
  }

  void getShipmentRecordList() {
    print("result===>>>shipmentRecord");
    homeUseCase.getShipmentRecordList().then((value) {
      print("result===>>>shipmentRecord ${value}");
      if (value != null) {
          value.forEach((v) {
          shipmentRecordListData.add(ShipmentRecordData.fromJson(v));
        });
      }
    });
  }

  void getInAppNoticeById() {
    homeUseCase.getInAppNoticeById().then((value) {
      if(value!.isNotEmpty){
        inAppNoticeList.value = value;
      }
    });
  }

  logout(){
    homeUseCase.logout().then((value) {
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
