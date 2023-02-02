import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';
import '../../account_information/domain/account_information_use_case.dart';
import '../presentation/controllers/update_information_controller.dart';

class UpdateInformationBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<AccountInformationUseCase>(
        () => AccountInformationUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => UpdateInformationController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<AccountInformationUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
