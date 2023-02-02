

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/ui/home/model/in_app_notice_model.dart';
import 'package:jumppoint_app/ui/home/model/shipment_record_list_model.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../utills/apis/api_helper.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class HomeUseCase extends ApiHelper {
  HomeUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
      connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<ResponseHandler?> getUserInfo()async {
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

  Future<ResponseHandler?> getShipmentStatus()async {
    try {
      final result = await getMethod(ApiClient.shipmentStatus);
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

  Future<List<dynamic>?> getShipmentRecordList()async {
    Map<String, dynamic> shipmentRecordListParams = {
      "limit": "6","offset": "1"
    };
    try {
      final result = await getMethod(ApiClient.shipmentList , params: shipmentRecordListParams);
      print("result---------${result.body}");
      if(result.statusCode == 200){
        print("result.json ---- ${json.decode(result.body)}");
        return json.decode(result.body);
      }else{
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr.split(","));
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

  Future<List<InAppNotice>?> getInAppNoticeById()async {
    try {
      String lanCode = sharedPreferenceController.getNormal(PrefKeys.keyLanguageCode)??"";
      final result = await getMethod(ApiClient.inAppNoticeById);
      if (result.statusCode  == 200) {
        if(json.decode(result.body) is List){
          final response = List<InAppNotice>.from(json.decode(result.body).map((x) => InAppNotice.fromJson(x,lanCode)));
          return response;
        }
      } else {
        return [];
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
        progressController.showProgressDialog(false);
        return response;
      }
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

}
