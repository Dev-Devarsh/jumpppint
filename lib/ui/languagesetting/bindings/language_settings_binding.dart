import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/languagesetting/domain/language_settings_user_case.dart';
import 'package:jumppoint_app/ui/languagesetting/presentation/controllers/language_settings_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class LanguageSettingsBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<LanguageSettingsUseCase>(
        () => LanguageSettingsUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => LanguageSettingsController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<LanguageSettingsUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
