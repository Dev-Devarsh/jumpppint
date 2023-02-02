import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:jumppoint_app/di/di.dart';
import 'package:jumppoint_app/ui/reportExport/domain/report_export_use_case.dart';
import 'package:jumppoint_app/ui/reportExport/presentation/controllers/report_export_controller.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class ReportExportBinding extends Bindings {
  @override
  void dependencies() {
    DependencyProvider.registerFactory<ReportExportUseCase>(
        () => ReportExportUseCase(
              DependencyProvider.get<ConnectionController>(),
              DependencyProvider.get<SharedPreferenceController>(),
              DependencyProvider.get<ProgressController>(),
            ));

    DependencyProvider.registerLazySingleton(() => ReportExportController(
          DependencyProvider.get<ProgressController>(),
          DependencyProvider.get<ReportExportUseCase>(),
          DependencyProvider.get<SharedPreferenceController>(),
        ));
  }
}
