import 'package:get/get.dart';

import 'logger/logger.dart';

class ProgressController extends GetxController {
  final progressDialogStreamController = false.obs;
  final disableStreamController = false.obs;

  void showProgressDialog(bool value) {
    // Logger.dev('@8 value is $value');
    progressDialogStreamController.value = value;
  }

  void disableWidgets(bool value) {
    // Logger.dev('@13 value is $value');
    progressDialogStreamController.value = value;
  }

  @override
  void dispose() {
    progressDialogStreamController.close();
    disableStreamController.close();
    super.dispose();
  }
}
