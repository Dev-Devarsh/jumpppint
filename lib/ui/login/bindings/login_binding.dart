import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../di/di.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';
import '../domain/login_use_case.dart';
import '../presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<LoginUseCase>(() => LoginUseCase(
          DependencyProvider.get<ConnectionController>(),
          DependencyProvider.get<SharedPreferenceController>(),
          DependencyProvider.get<ProgressController>(),
        ));

    DependencyProvider.registerLazySingleton(() => LoginController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<LoginUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
