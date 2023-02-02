import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/updatepassword/domain/updatepassword_user_case.dart';
import 'package:jumppoint_app/ui/updatepassword/presentation/controllers/updatepassword_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class UpdatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<UpdatePasswordUseCase>(
        () => UpdatePasswordUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => UpdatePasswordController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<UpdatePasswordUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
