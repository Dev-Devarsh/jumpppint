import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/pref_keys.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../../utills/apis/api_helper.dart';
import '../../../../../utills/connection/connection_manager.dart';
import '../../../../../utills/preference/shared_preference.dart';
import '../../../../../utills/progress_controller.dart';

class ApplyForAccountUseCase extends ApiHelper {
  ApplyForAccountUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
      connectionManager, sharedPreferenceController, progressController);
  @override
  SharedPreferenceController sharedPreferenceController;

  Future<Map<String,dynamic>?> doRegister(
      String email,
      String password,
      String jpReferral,
      String merchantName,
      String name,
      String phone,
      String remarks,
      ) async {
    Map<String, dynamic> registerData = {
      "email": email,
      "password": password,
      "jpReferral": jpReferral,
      "merchantName": merchantName,
      "name": name,
      "phone": phone,
      "remarks": remarks,

    };
    debugPrint('request : ${registerData.toString()}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.register,
          body: jsonEncode(registerData).toString());
      print("ApiService Post Response Code : ${result.statusCode}");
      print("statusCode----${result.statusCode}");
      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
        sharedPreferenceController.setLogin(true);
        return json.decode(result.body);
      }else{
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr.split(","));
      }
      /*final response = ResponseHandler.fromJson(json.decode(result.body));
      debugPrint("Response: ${jsonEncode(response.toJson())}");
      if (!response.isSuccess) {
        sharedPreferenceController.saveData(PrefKeys.token , response.token);
        print("response.token========${response.token}");
        if (response.message!.isNotEmpty) {
          Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        } else {
          Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
          throw CustomException(response.message ?? "");
        }
        return response;
      } else {
        return response;
      }*/
    } catch (e, s) {
      debugPrint("we got $e $s");
      rethrow;
    }
  }

}
