import 'package:get/get.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/transaction_record/domain/transaction_record_use_case.dart';
import 'package:jumppoint_app/ui/transaction_record/presentation/controllers/transaction_record_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class TransactionRecordBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<TransactionRecordUseCase>(
        () => TransactionRecordUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => TransactionRecordController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<TransactionRecordUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
