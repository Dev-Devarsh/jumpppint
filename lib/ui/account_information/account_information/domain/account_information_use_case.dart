import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/apis/api_helper.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class AccountInformationUseCase extends ApiHelper {
  AccountInformationUseCase(ConnectionController, connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<ResponseHandler?> getAccountInfo()async {
    try {
      final result = await getMethod(ApiClient.userInfo);
      final response = ResponseHandler.fromJson(json.decode(result.body));
      if (!response.isSuccess) {
        if (response.error != null) {
          Utils.displayErrorToast(response.error?.message??"");
        } else {
          Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
          throw CustomException(response.message ?? []);
        }
        return response;
      } else {
        return response;
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

  Future<ResponseHandler?> updateAccountInfo(Map<String, dynamic> updateData)async {
    try {
      progressController.showProgressDialog(true);
      final result = await patchMethod(ApiClient.userInfo,body: jsonEncode(updateData));
      final response = ResponseHandler.fromJson(json.decode(result.body));
      if (!response.isSuccess) {
        progressController.showProgressDialog(false);
        if (response.error != null) {
          Utils.displayErrorToast(response.error?.message??"");
        } else {
          Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
          throw CustomException(response.message ?? []);
        }
        return response;
      } else {
        progressController.showProgressDialog(false);
        return response;
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }
}
