import 'package:jumppoint_app/manager/my_notification_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

import '../di/di.dart';
import 'apis/api_helper.dart';
import 'apis/api_provider.dart';
import 'connection/connection_manager.dart';

class AppComponentBase {
  static void registerDependencies() {
    DependencyProvider.registerSingleton<MyNotificationManager>(MyNotificationManager());
    DependencyProvider.registerSingleton<ConnectionController>(
        ConnectionController(),
        permanent: true);
    DependencyProvider.registerFactory<SharedPreferenceController>(
        () => SharedPreferenceController(),
        permanent: true);
    DependencyProvider.registerSingleton<ProgressController>(
        ProgressController(),
        permanent: true);
    DependencyProvider.registerSingleton<IApiProvider>(
        ApiProviderImpl(DependencyProvider.get<ConnectionController>(),
            DependencyProvider.get<SharedPreferenceController>()),
        permanent: true);
    DependencyProvider.registerSingleton<ApiHelper>(
        ApiHelper(
            DependencyProvider.get<ConnectionController>(),
            DependencyProvider.get<SharedPreferenceController>(),
            DependencyProvider.get<ProgressController>()),
        permanent: true);
  }
}
