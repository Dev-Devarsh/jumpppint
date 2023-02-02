import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/order_details/domain/order_detail_user_case.dart';
import 'package:jumppoint_app/ui/order_details/presentation/controllers/order_detail_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<OrderDetailsUseCase>(
        () => OrderDetailsUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => OrderDetailsController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<OrderDetailsUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));

  }
}
