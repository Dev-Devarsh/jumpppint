import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../utills/apis/api_helper.dart';
import '../../../utills/connection/connection_manager.dart';
import '../../../utills/preference/shared_preference.dart';
import '../../../utills/progress_controller.dart';

class ReportExportUseCase extends ApiHelper {
  ReportExportUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<ResponseHandler?> getShipmentAddressSearch(String searchAddress )async {
    try {
      final result = await getMethod(ApiClient.shipmentAddressSearchCO + "?address=${searchAddress}");
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

  Future<ResponseHandler?> getExportShipmentRecord(String dateFrom, String dateTo)async {
    try {
      final result = await getMethod("${ApiClient.exportShipmentReport}?dateFrom=$dateFrom&dateTo=$dateTo");
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

  Future<ResponseHandler?> getExportBalanceRecord(String dateFrom, String dateTo)async {
    try {
      final result = await getMethod("${ApiClient.exportBalanceReport}?dateFrom=$dateFrom&dateTo=$dateTo");
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
