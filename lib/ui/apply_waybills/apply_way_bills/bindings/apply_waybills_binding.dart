import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../domain/apply_waybills_use_case.dart';
import '../presentation/controllers/apply_waybills_controller.dart';

class ApplyWayBillsBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ApplyWayBillsUseCase>(
        () => ApplyWayBillsUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => ApplyWayBillsController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<ApplyWayBillsUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
