import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/apis/api_helper.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class DeleteAccountUseCase extends ApiHelper {
  DeleteAccountUseCase(ConnectionController, connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<Map<String,dynamic>?> doDeleteAccount(String accountBenefitiaryName, String bankNumber, String bank) async {
    Map<String, dynamic> deleteData = {
      "bank": bank,
      "bankAccountNumber": bankNumber,
      "bankBeneficiary": accountBenefitiaryName,
    };

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.deleteAccount,
          body: jsonEncode(deleteData).toString());
      print("result===>>> ${result.body}");
      if (result.statusCode == 201) {
        progressController.showProgressDialog(false);
        return json.decode(result.body);
      } else {
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr.split(","));
      }
    }catch (e, s){
      debugPrint("we got $e $s");
      rethrow;
    }
  }
}
