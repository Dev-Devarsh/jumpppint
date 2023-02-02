import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../../utills/apis/api_helper.dart';
import '../../../../../utills/connection/connection_manager.dart';
import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';

class SmsVerificationUseCase extends ApiHelper {
  SmsVerificationUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
      connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<Map<String,dynamic>?> doInitOtp(
      String userId,
      ) async {
    Map<String, dynamic> initOtpData = {
      "userId": userId,
    };
    debugPrint('request : ${initOtpData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.initOtp,
          body: jsonEncode(initOtpData));
      print("ApiService Post Response Code : ${result.statusCode}");

      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
        sharedPreferenceController.setLogin(true);
        return json.decode(result.body);
      }else{
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr);
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

  Future<Map<String,dynamic>?> doVerifyOtp(
      String otp,
      String userId,
      ) async {
    Map<String, dynamic> verifyOtpData = {
      "otp": otp,
      "userId": userId,
    };
    debugPrint('request : ${verifyOtpData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.verifyOtp,
          body: jsonEncode(verifyOtpData));
      print("ApiService Post Response Code : ${result.statusCode}");

      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
        sharedPreferenceController.setLogin(true);
        return json.decode(result.body);
      }else{
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr);
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

}
