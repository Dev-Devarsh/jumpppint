import 'package:get/get.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../domain/upload_completed_use_case.dart';
import '../presentation/controllers/upload_completed_controller.dart';

class UploadCompletedBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<UploadCompletedUseCase>(
        () => UploadCompletedUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => UploadCompletedController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<UploadCompletedUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
