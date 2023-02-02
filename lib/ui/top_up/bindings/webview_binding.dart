import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/top_up/domain/top_up_use_case.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/top_up_controller.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/webview_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class WebviewBinding extends Bindings{
  @override
  void dependencies() {
    DependencyProvider.registerFactory<TopUpUseCase>(() => TopUpUseCase(
      DependencyProvider.get<ConnectionController>(),
      DependencyProvider.get<SharedPreferenceController>(),
      DependencyProvider.get<ProgressController>(),
    ));

    DependencyProvider.registerLazySingleton(() => WebviewController(
      DependencyProvider.get<ProgressController>(),
      DependencyProvider.get<TopUpUseCase>(),
      DependencyProvider.get<SharedPreferenceController>(),
    ));
  }

}