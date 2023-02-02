import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:jumppoint_app/model/user_info.dart';

import '../../../../../routes.dart';
import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';
import '../../domain/account_information_use_case.dart';

class AccountInformationController extends SuperController {
  final ProgressController progressController;
  final AccountInformationUseCase accountInformationUseCase;
  final SharedPreferenceController sharedPreferenceController;

  AccountInformationController(this.progressController,
      this.accountInformationUseCase, this.sharedPreferenceController);

  final isSelected = false.obs;

  Rx<UserData?> userData = Rx<UserData?>(null);

  @override
  void onInit() async {
    super.onInit();
    getUserInfo();
  }

  @override
  void onDetached() {
  }

  @override
  void onInactive() {
  }

  @override
  void onPaused() {
  }

  @override
  void onResumed() {
  }

  void goTOUpdateInfoView() {
    Get.toNamed(RouteName.updateInfoPage, arguments: { 'userData' : userData.value })?.then((value) {
      getUserInfo();
    });
  }

  void goToDeleteAccountView() {
    Get.toNamed(RouteName.deleteAccountPage,arguments: {"userData":userData.value});
  }

  void getUserInfo() {
    accountInformationUseCase.getAccountInfo().then((value) {
      if (value != null) {
        print("result===>>>getAccountInfo ${value.toJson()}");
        userData.value = UserData.fromJson(value.result);
        print("result===>>>getAccountInfo ${userData.value?.name}");
      }
    });
  }
}
