import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/ui/home/domain/home_user_case.dart';
import 'package:jumppoint_app/ui/home/presentation/controllers/home_controller.dart';

import '../../../di/di.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<HomeUseCase>(() => HomeUseCase(
          DependencyProvider.get<ConnectionController>(),
          DependencyProvider.get<SharedPreferenceController>(),
          DependencyProvider.get<ProgressController>(),
        ));

    DependencyProvider.registerLazySingleton(() => HomeController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<HomeUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
