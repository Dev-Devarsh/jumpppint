import 'package:get/get.dart';
import 'package:jumppoint_app/ui/notification_center/domain/notification_center_use_case.dart';
import 'package:jumppoint_app/ui/notification_center/model/notification_center_model.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class NotificationCenterController extends SuperController {
  final ProgressController progressController;
  final NotificationCenterUseCase notificationCenterUseCase;
  final SharedPreferenceController sharedPreferenceController;

  NotificationCenterController(this.progressController,
      this.notificationCenterUseCase, this.sharedPreferenceController);

  RxList<NotificationCenterModel> notificationList = <NotificationCenterModel>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    onGetNotificationRecords();
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
  void onResumed() {
    // TODO: implement onResumed
  }

  void onGetNotificationRecords() {
    notificationList.add(
      NotificationCenterModel(
        notificationTitle: "Shipment #JP123456789 has completed",
        date: "2022-04-02 13:00",
        isRead: true,
      ),
    );
    notificationList.add(
      NotificationCenterModel(
        notificationTitle: "運單編號#JP123456789已經完成簽收",
        date: "2022-04-02 13:00",
        isRead: true,
      ),
    );
    notificationList.add(
      NotificationCenterModel(
        notificationTitle: "運單編號#JP123456789已經完成簽收",
        date: "2022-04-02 13:00",
        isRead: true,
      ),
    );
    notificationList.add(
      NotificationCenterModel(
        notificationTitle: "運單編號#JP123456789已經完成簽收",
        date: "2022-04-02 13:00",
        isRead: false,
      ),
    );
    notificationList.add(
      NotificationCenterModel(
        notificationTitle: "運單編號#JP123456789已經完成簽收",
        date: "2022-04-02 13:00",
        isRead: false,
      ),
    );
    notificationList.add(
      NotificationCenterModel(
        notificationTitle: "運單編號#JP123456789已經完成簽收",
        date: "2022-04-02 13:00",
        isRead: false,
      ),
    );
  }
}
