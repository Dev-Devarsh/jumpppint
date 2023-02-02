import 'package:get/get.dart';
import 'package:jumppoint_app/ui/top_up/domain/top_up_use_case.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class WebviewController extends SuperController {

  final ProgressController progressController;
  final TopUpUseCase topUpUseCase;
  final SharedPreferenceController sharedPreferenceController;

  WebviewController(this.progressController, this.topUpUseCase, this.sharedPreferenceController);

  final url = "".obs;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      url.value = Get.arguments;
    }
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
}
