import 'package:get/get.dart';
import 'package:jumppoint_app/ui/notificationsettings/domain/notification_settings_user_case.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class NotificationSettingsController extends SuperController {
  final ProgressController progressController;
  final NotificationSettingsUseCase notificationSettingsUseCase;
  final SharedPreferenceController sharedPreferenceController;

  NotificationSettingsController(this.progressController,
      this.notificationSettingsUseCase, this.sharedPreferenceController);

  RxBool isShipmentStatus = true.obs;
  RxBool isPromotion = true.obs;

  @override
  void onInit() async {
    isShipmentStatus.value = sharedPreferenceController.getBool(PrefKeys.keyIsShipmentStatusNotification);
    isPromotion.value = sharedPreferenceController.getBool(PrefKeys.keyIsPromotionStatusNotification);
    super.onInit();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() async {
    // TODO: implement onResumed
  }

  void shipmentStatusUpdate(bool value) {
    isShipmentStatus.value = value;
    sharedPreferenceController.saveBool(PrefKeys.keyIsShipmentStatusNotification, value);
  }

  void promotionStatusUpdate(bool value) {
    isPromotion.value = value;
    sharedPreferenceController.saveBool(PrefKeys.keyIsPromotionStatusNotification, value);
  }
}
