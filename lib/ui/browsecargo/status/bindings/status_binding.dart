import 'package:get/get.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../domain/status_use_case.dart';
import '../presentation/controllers/status_controller.dart';

class StatusBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<StatusUseCase>(() => StatusUseCase(
          DependencyProvider.get<ConnectionController>(),
          DependencyProvider.get<SharedPreferenceController>(),
          DependencyProvider.get<ProgressController>(),
        ));

    DependencyProvider.registerLazySingleton(() => StatusController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<StatusUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
