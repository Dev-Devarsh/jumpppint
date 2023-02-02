import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/ui/pickup_points/domain/pickup_point_use_case.dart';
import 'package:jumppoint_app/ui/pickup_points/presentation/controllers/pickup_point_controller.dart';

import '../../../di/di.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class PickupPointsBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<PickupPointsUseCase>(
        () => PickupPointsUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(
        () => PickupPointsController(
              DependencyProvider.get<ProgressController>(),
              DependencyProvider.get<PickupPointsUseCase>(),
              DependencyProvider.get<SharedPreferenceController>(),
            ));
  }
}
