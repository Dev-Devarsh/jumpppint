import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/apply_waybills/model/label_request_item.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/apis/api_helper.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
import '../../../../utills/progress_controller.dart';

class ApplyWayBillsUseCase extends ApiHelper {
  ApplyWayBillsUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
      connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<Map<String,dynamic>?> doLabelRequest(
      LabelRequestItem labelRequest,
      ) async {
    Map<String, dynamic> labelRequestData = {
      "labelRequest": labelRequest,
    };
    debugPrint('request : ${labelRequest.toJson()}');
    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.labelRequest,
          body: jsonEncode(labelRequestData));
      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
        return json.decode(result.body);
      }else{
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr.split(","));
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

  Future<ResponseHandler?> logout() async {
    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.logout);
      final response = ResponseHandler.fromJson(json.decode(result.body));
      print("object==>>> ${response.isSuccess}");
      if (!response.isSuccess) {
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(response.message??"");
        return response;
      } else {
        progressController.showProgressDialog(
          false
        );
        return response;
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }
}
