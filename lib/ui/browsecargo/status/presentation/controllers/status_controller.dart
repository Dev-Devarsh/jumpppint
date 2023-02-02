import 'package:get/get.dart';
import 'package:jumppoint_app/ui/browsecargo/status/domain/status_use_case.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';

class StatusController extends SuperController {

  final ProgressController progressController;
  final StatusUseCase statusUseCase;
  final SharedPreferenceController sharedPreferenceController;

  StatusController(this.progressController, this.statusUseCase,
      this.sharedPreferenceController);

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
