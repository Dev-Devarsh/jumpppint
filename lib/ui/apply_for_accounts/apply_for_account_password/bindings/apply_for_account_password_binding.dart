import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account/domain/apply_for_account_use_case.dart';
import 'package:jumppoint_app/ui/apply_for_accounts/apply_for_account/presentation/controllers/apply_for_account_controller.dart';

import '../../../../di/di.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class ApplyForAccountPasswordBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ApplyForAccountUseCase>(
        () => ApplyForAccountUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(
        () => ApplyForAccountController(
              DependencyProvider.get<ProgressController>(),
              DependencyProvider.get<ApplyForAccountUseCase>(),
              DependencyProvider.get<SharedPreferenceController>(),
            ));
  }
}
