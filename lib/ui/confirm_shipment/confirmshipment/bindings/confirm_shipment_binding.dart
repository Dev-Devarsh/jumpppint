import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/domain/confirm_shipment_use_case.dart';
import 'package:jumppoint_app/ui/confirm_shipment/confirmshipment/presentation/controllers/confirm_shipment_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ConfirmShipmentBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ConfirmShipmentUseCase>(() => ConfirmShipmentUseCase(
      DependencyProvider.get<ConnectionController>(),
      DependencyProvider.get<SharedPreferenceController>(),
      DependencyProvider.get<ProgressController>(),
    ));

    DependencyProvider.registerLazySingleton(() => ConfirmShipmentController(
      DependencyProvider.get<ProgressController>(),
      DependencyProvider.get<ConfirmShipmentUseCase>(),
      DependencyProvider.get<SharedPreferenceController>(),
    ));
  }
}