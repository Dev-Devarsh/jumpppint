import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../domain/account_information_use_case.dart';
import '../presentation/controllers/account_information_controller.dart';

class AccountInformationBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<AccountInformationUseCase>(
        () => AccountInformationUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => AccountInformationController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<AccountInformationUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
