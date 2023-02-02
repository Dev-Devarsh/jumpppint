import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../../type/domain/type_use_case.dart';
import '../../type/presentation/controllers/type_controller.dart';

class CheckoutBinding extends Bindings {
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
