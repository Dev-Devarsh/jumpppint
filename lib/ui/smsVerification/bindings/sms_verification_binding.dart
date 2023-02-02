import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/smsVerification/domain/sms_verification_user_case.dart';
import 'package:jumppoint_app/ui/smsVerification/presentation/controllers/sms_verification_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class SmsVerificationBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<SmsVerificationUseCase>(
        () => SmsVerificationUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(
        () => SmsVerificationController(
              DependencyProvider.get<ProgressController>(),
              DependencyProvider.get<SmsVerificationUseCase>(),
              DependencyProvider.get<SharedPreferenceController>(),
            ));
  }
}
