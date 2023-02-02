import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/ui/notification_center/domain/notification_center_use_case.dart';
import 'package:jumppoint_app/ui/notification_center/presentation/controllers/notification_center_controller.dart';

import '../../../di/di.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class NotificationCenterBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<NotificationCenterUseCase>(
        () => NotificationCenterUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(
        () => NotificationCenterController(
              DependencyProvider.get<ProgressController>(),
              DependencyProvider.get<NotificationCenterUseCase>(),
              DependencyProvider.get<SharedPreferenceController>(),
            ));
  }
}
