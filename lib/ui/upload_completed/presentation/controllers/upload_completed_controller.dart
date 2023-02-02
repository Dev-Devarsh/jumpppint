import 'package:get/get.dart';
import 'package:jumppoint_app/ui/upload_completed/domain/upload_completed_use_case.dart';

import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';

class UploadCompletedController extends SuperController {

  final ProgressController progressController;
  final UploadCompletedUseCase uploadCompletedUseCase;
  final SharedPreferenceController sharedPreferenceController;

  UploadCompletedController(this.progressController, this.uploadCompletedUseCase,
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
