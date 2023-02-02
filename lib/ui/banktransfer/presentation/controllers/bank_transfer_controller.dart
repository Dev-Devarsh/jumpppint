import 'package:get/get.dart';
import 'package:jumppoint_app/ui/banktransfer/domain/bank_transfer_use_case.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';

class BankTransferController extends SuperController {

  final ProgressController progressController;
  final BankTransferUseCase bankTransferUseCase;
  final SharedPreferenceController sharedPreferenceController;

  BankTransferController(this.progressController, this.bankTransferUseCase,
      this.sharedPreferenceController);

  @override
  void onInit() {
    super.onInit();
    print("onInit object--");
    getBankTransferAc();
  }

  @override
  void onDetached() {
    print("onInit object---");
  }

  @override
  void onInactive() {
    print("onInit object----");
  }

  @override
  void onPaused() {
    print("onInit object-----");
  }

  @override
  void onResumed() {
    getBankTransferAc();
  }

  void getBankTransferAc() {
    print("getBankTransferAc---------");
    bankTransferUseCase.getBankTransferAc().then((value) {
      if (value != null) {
        print("getBankTransferAc---------${value.result}");
        // value.result['paymentMethods'].forEach((v) {
        //   paymentMethodList.add(PaymentMethods.fromJson(v));
        // });
        // print("paymentMethodList===>>> ${paymentMethodList.length}");
      } else {
        print("object");
      }
    });
  }

}
