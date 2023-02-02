import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/notificationsettings/domain/notification_settings_user_case.dart';
import 'package:jumppoint_app/ui/notificationsettings/presentation/controllers/notification_settings_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class NotificationSettingsBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<NotificationSettingsUseCase>(
        () => NotificationSettingsUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => NotificationSettingsController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<NotificationSettingsUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
