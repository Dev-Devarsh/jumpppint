import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/create_order/type/domain/type_use_case.dart';
import 'package:jumppoint_app/ui/create_order/type/presentation/controllers/type_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class AddressesBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<TypeUseCase>(() => TypeUseCase(
      DependencyProvider.get<ConnectionController>(),
      DependencyProvider.get<SharedPreferenceController>(),
      DependencyProvider.get<ProgressController>(),
    ));

    DependencyProvider.registerLazySingleton(() => TypeController(
      DependencyProvider.get<ProgressController>(),
      DependencyProvider.get<TypeUseCase>(),
      DependencyProvider.get<SharedPreferenceController>(),
    ));
  }
}