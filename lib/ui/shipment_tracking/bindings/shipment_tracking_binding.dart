import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/shipment_tracking/domain/shipment_tracking_use_case.dart';
import 'package:jumppoint_app/ui/shipment_tracking/presentation/controllers/shipment_tracking_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ShipmentTrackingBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ShipmentTrackingUseCase>(() => ShipmentTrackingUseCase(
      DependencyProvider.get<ConnectionController>(),
      DependencyProvider.get<SharedPreferenceController>(),
      DependencyProvider.get<ProgressController>(),
    ));

    DependencyProvider.registerLazySingleton(() => ShipmentTrackingController(
      DependencyProvider.get<ProgressController>(),
      DependencyProvider.get<ShipmentTrackingUseCase>(),
      DependencyProvider.get<SharedPreferenceController>(),
    ));
  }
}