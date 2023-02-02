import 'package:get/get.dart';
import 'package:jumppoint_app/routes.dart';
import 'package:jumppoint_app/ui/transaction_record/domain/transaction_record_use_case.dart';
import 'package:jumppoint_app/ui/transaction_record/model/transaction_record_model.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/utils.dart';

class TransactionRecordController extends SuperController {

  final ProgressController progressController;
  final TransactionRecordUseCase transactionRecordUseCase;
  final SharedPreferenceController sharedPreferenceController;

  TransactionRecordController(this.progressController, this.transactionRecordUseCase, this.sharedPreferenceController);

  final paymentLogs = <PaymentLogs?>[].obs;
  final paymentsByDates = <PaymentLogs?>[].obs;
  final paymentsData = [].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getTransactionRecord();
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

  void getTransactionRecord() {
    transactionRecordUseCase.getTransactionRecord().then((value) {
      if (value != null) {
        print("getTransactionRecord---------${value.result}");
        value.result['paymentLogs'].forEach((v) {
          paymentLogs.add(PaymentLogs.fromJson(v));
        });
        print("paymentLogs===>>> ${paymentLogs.length}");
      } else {
        print("object");
      }
    });
  }
}
