import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/domain/forgotpassword_user_case.dart';
import 'package:jumppoint_app/ui/forgot_password/forgotpassword/presentation/controllers/forgotpassword_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ForgotPasswordEmailBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(
        () => ForgotPasswordController(
              DependencyProvider.get<ProgressController>(),
              DependencyProvider.get<ForgotPasswordUseCase>(),
              DependencyProvider.get<SharedPreferenceController>(),
            ));
  }
}
