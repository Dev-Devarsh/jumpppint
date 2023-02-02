import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../domain/delete_account_use_case.dart';
import '../presentation/controlleres/delete_account_controller.dart';

class DeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<DeleteAccountUseCase>(
        () => DeleteAccountUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => DeleteAccountController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<DeleteAccountUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
