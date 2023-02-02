import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../utills/apis/api_helper.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class PickupPointsUseCase extends ApiHelper {
  PickupPointsUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
      connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

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
        progressController.showProgressDialog(false);
        return response;
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

}
