import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

import '../domain/batch_create_use_case.dart';
import '../presentation/controllers/batch_create_controller.dart';

class BatchCreateBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<BatchCreateUseCase>(
        () => BatchCreateUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => BatchCreateController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<BatchCreateUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
