import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/apply_waybills/apply_way_bills/domain/apply_waybills_use_case.dart';
import 'package:jumppoint_app/ui/apply_waybills/apply_way_bills/presentation/controllers/apply_waybills_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class WayBillsAddressBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ApplyWayBillsUseCase>(
        () => ApplyWayBillsUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => ApplyWayBillsController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<ApplyWayBillsUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
