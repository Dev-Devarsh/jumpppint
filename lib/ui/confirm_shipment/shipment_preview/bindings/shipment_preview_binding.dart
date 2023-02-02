import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/confirm_shipment/shipment_preview/domain/shipment_preview_use_case.dart';
import 'package:jumppoint_app/ui/confirm_shipment/shipment_preview/presentation/controllers/shipment_preview_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ConfirmShipmentPreviewBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ConfirmShipmentPreviewUseCase>(() => ConfirmShipmentPreviewUseCase(
      DependencyProvider.get<ConnectionController>(),
      DependencyProvider.get<SharedPreferenceController>(),
      DependencyProvider.get<ProgressController>(),
    ));

    DependencyProvider.registerLazySingleton(() => ConfirmShipmentPreviewController(
      DependencyProvider.get<ProgressController>(),
      DependencyProvider.get<ConfirmShipmentPreviewUseCase>(),
      DependencyProvider.get<SharedPreferenceController>(),
    ));
  }
}