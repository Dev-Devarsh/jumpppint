import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/apis/api_helper.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../../utills/apis/api_client.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/exceptions/app_exception.dart';
import '../../../utills/generated/locales.g.dart';
import '../../../utills/pref_keys.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';
import '../../../utills/response_handler.dart';
import '../../../utills/utils.dart';

class LoginUseCase extends ApiHelper {
  LoginUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, this.progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  @override
  ProgressController progressController;

  Future<Map<String, dynamic>?> doLogin(
    String email,
    String password,
  ) async {
    Map<String, dynamic> loginData = {
      "username": email,
      "password": password,
      "device_id": await PlatformDeviceId.getDeviceId,
      "device_token": "fcmToken",
      /*  "latitude": latitude,
      "longitude": longitude,*/
    };
    debugPrint('request : ${loginData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.login,
          body: jsonEncode(loginData).toString());
      print("statusCode----${result.body}");
      if (result.statusCode == 201) {
        sharedPreferenceController.setLogin(true);
        progressController.showProgressDialog(false);
        return json.decode(result.body);
      } else {
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr.split(","));
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

  Future<Map<String,dynamic>?> doInitOtp(
      String email,
      ) async {
    Map<String, dynamic> initOtpData = {
      "username": email,
    };
    debugPrint('request : ${initOtpData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.initResetOtp,
          body: jsonEncode(initOtpData));
      print("ApiService Post Response Code : ${result.statusCode}");

      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
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
