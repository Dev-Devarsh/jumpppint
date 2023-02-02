import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';

import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';
import '../domain/browser_cargo_use_case.dart';
import '../presentation/controllers/browse_cargo_controller.dart';

class BrowseCargoBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<BrowserCargoUseCase>(
        () => BrowserCargoUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => BrowseCargoController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<BrowserCargoUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
