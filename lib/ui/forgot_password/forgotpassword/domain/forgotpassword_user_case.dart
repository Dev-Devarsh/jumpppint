

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/apis/api_helper.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class ForgotPasswordUseCase extends ApiHelper {
  ForgotPasswordUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
      connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

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

  Future<Map<String,dynamic>?> doVerifyOtp(String email, String otp) async {
    Map<String, dynamic> initOtpData = {
      "username": email,
      "otp": otp,
    };
    debugPrint('request : ${initOtpData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.verifyResetOtp,
          body: jsonEncode(initOtpData));
      print("ApiService Post Response Code : ${result.statusCode}");
      print("ApiService Post Response Code : ${result.body}");

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

  Future<Map<String,dynamic>?> doChangePassword(String newPassword,String accessToken) async {
    Map<String, dynamic> changePasswordData = {
      "newPassword": newPassword,
    };
    Map<String, String> changePasswordHeaders = {
      "Authorization": 'Bearer $accessToken',
    };
    debugPrint('request : ${changePasswordData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await patchMethod(ApiClient.passwordResetOtp,
          body: jsonEncode(changePasswordData),headers: changePasswordHeaders);
      print("ApiService Post Response Code : ${result.statusCode}");
      print("ApiService Post Response Code : ${result.body}");

      if(result.statusCode == 200){
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
