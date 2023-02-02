import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/ui/top_up/domain/top_up_use_case.dart';
import 'package:jumppoint_app/ui/top_up/presentation/controllers/top_up_controller.dart';

import '../../../di/di.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class TopUpBalanceBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<TopUpUseCase>(() => TopUpUseCase(
          DependencyProvider.get<ConnectionController>(),
          DependencyProvider.get<SharedPreferenceController>(),
          DependencyProvider.get<ProgressController>(),
        ));

    DependencyProvider.registerLazySingleton(() => TopUpController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<TopUpUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
