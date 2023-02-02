import 'package:get/get.dart';
import 'package:jumppoint_app/ui/browsecargo/domain/browser_cargo_use_case.dart';
import 'package:jumppoint_app/ui/browsecargo/presentation/controllers/browse_cargo_controller.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class WayBillBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<BrowserCargoUseCase>(() => BrowserCargoUseCase(
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
