import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/banktransfer/domain/bank_transfer_use_case.dart';
import 'package:jumppoint_app/ui/banktransfer/presentation/controllers/bank_transfer_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';


class BankTransferBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<BankTransferUseCase>(
        () => BankTransferUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => BankTransferController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<BankTransferUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
