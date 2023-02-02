import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/apis/api_helper.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

class ShipmentTrackingUseCase extends ApiHelper {
  ShipmentTrackingUseCase(ConnectionController connectionManager,
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


  Future<List<dynamic>?> getShipmentRecordList(Map<String, dynamic> shipmentRecordListParams)async {
    try {
      final result = await getMethod(ApiClient.shipmentList , params: shipmentRecordListParams);
      print("result---------${result.body}");
      if(result.statusCode == 200){
        print("result.json ---- ${json.decode(result.body)}");
        return json.decode(result.body);
      }else{
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException([LocaleKeys.someThingWrong.tr]);
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }


  Future<ResponseHandler?> getShipmentStatusSummary()async {
    try {
      final result = await getMethod(ApiClient.shipmentStatusSummary);
      final response = ResponseHandler.fromJson(json.decode(result.body));
      if (!response.isSuccess) {
        if (response.error != null) {
          Utils.displayErrorToast(response.error?.message??"");
        } else {
          Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
          throw CustomException([response.message ?? ""]);
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

  Future<ResponseHandler?> getAreaRankList()async {
    try {
      final result = await getMethod(ApiClient.areaRankList);
      final response = ResponseHandler.fromJson(json.decode(result.body));
      if (!response.isSuccess) {
        if (response.error != null) {
          Utils.displayErrorToast(response.error?.message??"");
        } else {
          Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
          throw CustomException([response.message ?? ""]);
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
}
