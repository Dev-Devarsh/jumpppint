import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

import '../../batchcreate/domain/batch_create_use_case.dart';
import '../../batchcreate/presentation/controllers/batch_create_controller.dart';

class BulkOrderPreviewBinding extends Bindings {
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
