import 'package:get/get.dart';
import 'package:jumppoint_app/model/user_info.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/top_up/domain/top_up_use_case.dart';
import 'package:jumppoint_app/ui/top_up/model/payment_topup_model.dart';
import 'package:jumppoint_app/ui/top_up/model/top_up_model.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/utils.dart';

class TopUpController extends SuperController {
  final ProgressController progressController;
  final TopUpUseCase topUpUseCase;
  final SharedPreferenceController sharedPreferenceController;

  TopUpController(this.progressController, this.topUpUseCase,
      this.sharedPreferenceController);

  RxList<TopUpModel> topUpList = <TopUpModel>[].obs;

  RxBool amount = false.obs;
  var arguments = Get.arguments;

  final paymentMethodList = <PaymentMethods?>[].obs;
  List<dynamic> amountOptionsList = <dynamic>[].obs;
  Rx<UserData?> userData = Rx<UserData?>(null);

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {

    }
    getUserInfo();
    getPaymentTopUp();
  }

  void clearFocus() {
    Get.focusScope!.unfocus();
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

  ///API

  void getAddCardURL() {
    topUpUseCase.getAddCardURL().then((value) {
      if (value != null) {
        print("object ${value.result["url"]}");
        Get.toNamed(RouteName.webView,arguments: value.result["url"]);
      } else {
        print("object");
      }
    });
  }

  void getPaymentTopUp() {
    topUpUseCase.getPaymentTopUp().then((value) {
      if (value != null) {
        print("getPaymentTopUp---------${value.result}");
        value.result['paymentMethods'].forEach((v) {
          paymentMethodList.add(PaymentMethods.fromJson(v));
        });
        print("paymentMethodList===>>> ${paymentMethodList.length}");
      } else {
        print("object");
      }
    });
  }

  void getPaymentTopUpAmountOption() {
    topUpUseCase.getPaymentTopUpAmountOption().then((value) {
      if (value != null) {
        print("getPaymentTopUpAmountOption---------${value.result}");
        amountOptionsList = value.result['hk']['amountOptions'];
        print("amountOptionsList===>>> ${value.result['hk']['amountOptions']}");
        Get.toNamed(RouteName.topUpBalance);
      } else {
        print("object");
      }
    });
  }

  void getUserInfo() {
    topUpUseCase.getAccountInfo().then((value) {
      if (value != null) {
        userData.value = UserData.fromJson(value.result);
      }
    });
  }

  void logout() {
    topUpUseCase.logout().then((value) {
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
