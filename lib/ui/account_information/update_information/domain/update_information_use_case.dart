import '../../../../utills/apis/api_helper.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class UpdateInformationUseCase extends ApiHelper {
  UpdateInformationUseCase(ConnectionController, connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;
}
