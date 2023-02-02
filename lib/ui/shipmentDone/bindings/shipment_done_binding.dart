import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/shipmentDone/domain/shipment_done_use_case.dart';
import 'package:jumppoint_app/ui/shipmentDone/presentation/controllers/shipment_done_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ShipmentDoneBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ShipmentDoneUseCase>(
        () => ShipmentDoneUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => ShipmentDoneController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<ShipmentDoneUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
