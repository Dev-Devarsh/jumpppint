import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../domain/apply_for_account_use_case.dart';
import '../presentation/controllers/apply_for_account_controller.dart';

class ApplyForAccountBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ApplyForAccountUseCase>(
        () => ApplyForAccountUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => ApplyForAccountController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<ApplyForAccountUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
