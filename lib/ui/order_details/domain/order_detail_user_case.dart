import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/apis/api_helper.dart';
import 'package:jumppoint_app/utills/connection/connection_manager.dart';
import 'package:jumppoint_app/utills/constants.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/preference/shared_preference.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

class OrderDetailsUseCase extends ApiHelper {
  OrderDetailsUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<ResponseHandler?> getOrderDetails(String? searchText) async {
    Map<String, dynamic> shipmentRecordListParams = {
      "id": searchText ?? StringConstants.trackingId
    };
    try {
      final result = await getMethod(ApiClient.shipmentDetailsList,
          params: shipmentRecordListParams);
      final response = ResponseHandler.fromJson(json.decode(result.body));
      if (!response.isSuccess) {
        if (response.error != null) {
          Utils.displayErrorToast(response.error?.message ?? "");
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

  Future<ResponseHandler?> getShipmentLabel(String trackingNumber) async {
    try {
      final result = await getMethod("${ApiClient.labelShipment}/$trackingNumber");
      final response = ResponseHandler.fromJson(json.decode(result.body));
      if (!response.isSuccess) {
        if (response.error != null) {
          Utils.displayErrorToast(response.error?.message ?? "");
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
