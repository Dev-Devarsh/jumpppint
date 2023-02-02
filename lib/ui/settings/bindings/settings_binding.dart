import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/settings/domain/settings_use_case.dart';
import 'package:jumppoint_app/ui/settings/presentation/controllers/settings_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<SettingsUseCase>(() => SettingsUseCase(
          DependencyProvider.get<ConnectionController>(),
          DependencyProvider.get<SharedPreferenceController>(),
          DependencyProvider.get<ProgressController>(),
        ));

    DependencyProvider.registerLazySingleton(() => SettingsController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<SettingsUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
