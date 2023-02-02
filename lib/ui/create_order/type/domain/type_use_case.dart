
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:jumppoint_app/ui/create_order/model/parcel_model.dart';
import 'package:jumppoint_app/utills/apis/api_client.dart';
import 'package:jumppoint_app/utills/exceptions/app_exception.dart';
import 'package:jumppoint_app/utills/generated/locales.g.dart';
import 'package:jumppoint_app/utills/progress_controller.dart';
import 'package:jumppoint_app/utills/response_handler.dart';
import 'package:jumppoint_app/utills/utils.dart';

import '../../../../utills/apis/api_helper.dart';
import '../../../../utills/connection/connection_manager.dart';
import '../../../../utills/preference/shared_preference.dart';
class TypeUseCase extends ApiHelper {
  TypeUseCase(ConnectionController connectionManager,
      this.sharedPreferenceController, ProgressController progressController)
      : super(
            connectionManager, sharedPreferenceController, progressController);

  @override
  SharedPreferenceController sharedPreferenceController;

  //Type
  Future<ResponseHandler?> getExpressDate()async {
    try {
      final result = await getMethod(ApiClient.findDateCO);
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

  //Parcels

  Future<ResponseHandler?> getValidateTrackingNo(String validateTrackingNo)async {
    try {
      final result = await getMethod(ApiClient.validateTrackingNoCO + validateTrackingNo);
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

  Future<ResponseHandler?> getItemOption(String shipmentType)async {
    try {
      final result = await getMethod(ApiClient.itemOptionCO + shipmentType);
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

  Future<ResponseHandler?> getItemPreviousParcel(String shipmentType)async {
    try {
      final result = await getMethod(ApiClient.itemPreviousParcelCO + shipmentType);
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

  //Address
  Future<Map<String,dynamic>?> doPickUpStoreOption(
      String? shipmentType,
      dynamic items,
      ) async {
    Map<String, dynamic> pickUpStoreOptionData = {
      "shipmentType": shipmentType,
      "items": items,
    };
    debugPrint('request : ${pickUpStoreOptionData}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.pickUpStoreOptionCO,
          body: jsonEncode(pickUpStoreOptionData));
      // debugPrint('response: ${result.body}');
      if(result.statusCode == 200){
        progressController.showProgressDialog(false);
        print("result body : ${json.decode(result.body)}");
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

  Future<ResponseHandler?> getShipmentAddressSearch(String searchAddress )async {
    try {
      final result = await getMethod("${ApiClient.shipmentAddressSearchCO}?address=$searchAddress");
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

  Future<Map<String,dynamic>?> doAddress(
      dynamic address,
      String? type,
      ) async {
    Map<String, dynamic> addressData = {
      "address": address,
      "type": type,
    };
    debugPrint('request : ${addressData}');

    try {
      progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.addressCO,
          body: jsonEncode(addressData));
      // debugPrint('response: ${result.body}');
      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
        print("result body : ${json.decode(result.body)}");
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

  Future<ResponseHandler?> getShipmentAddress()async {
    try {
      final result = await getMethod(ApiClient.shipmentAddressCO + "merchantId");
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

  Future<ResponseHandler?> getAddressFilter()async {
    try {
      final result = await getMethod(ApiClient.areaRankList);
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

//  CheckOut
  Future<ResponseHandler?> getCheckOut(String pickUpStoreCode)async {
    Map<String,dynamic> pickUpStoreCodeParams = {
      'pickUpStoreCode' : pickUpStoreCode
    };
    try {
      final result = await getMethod(ApiClient.checkOutPaymentOptionCO , params: pickUpStoreCodeParams);
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

//  Shipment Preview
  Future<ResponseHandler?> getShipmentPreviewQuotation(String itemCount, String shipmentType)async {
    Map<String,dynamic> itemCountParams = {
      'itemCount' : itemCount
    };
    try {
      final result = await getMethod(ApiClient.shipmentPreviewQuotation + shipmentType, params: itemCountParams);
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

  Future<Map<String,dynamic>?> doCreateShipment(Map<String, dynamic> createShipmentData) async {

    debugPrint('request createShipmentData : ${createShipmentData}');

    // try {
    progressController.showProgressDialog(true);
      final result = await postMethod(ApiClient.createShipmentPreview,
          body: jsonEncode(createShipmentData));
      // debugPrint('createShipmentPreview: ${result.body}');
      if(result.statusCode == 201){
        progressController.showProgressDialog(false);
        print("createShipmentPreview result body : ${json.decode(result.body)}");
        return json.decode(result.body);
      }else{
        progressController.showProgressDialog(false);
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException([LocaleKeys.someThingWrong.tr]);
      }
    // } catch (e, s) {
    //   debugPrint("we got $e $s");
    //   rethrow;
    // }
  }

  /*Future<Map<String,dynamic>?> doCreateShipment(
      String? destinationAddressId,
      dynamic items,
      String? originAddressId,
      String? paymentMethod,
      bool sameDayDelivery,
      String? pickUpStoreCode,
      String? pickUpDate,
      String? deliveryDate,
      double cod,
      String? orderNotes,
      String? externalOrderNumber,
      String? webhookUrl,
      ) async {
    Map<String, dynamic> createShipmentData = {
      "destinationAddressId": destinationAddressId,
      "items": items,
      "originAddressId": originAddressId,
      "paymentMethod": paymentMethod,
      "sameDayDelivery": sameDayDelivery,
      "pickUpStoreCode": pickUpStoreCode,
      "pickUpDate": pickUpDate,
      "deliveryDate": deliveryDate,
      "cod": cod,
      "orderNotes": orderNotes,
      "externalOrderNumber": externalOrderNumber,
      "webhookUrl": webhookUrl,
    };
    debugPrint('request createShipmentData : ${createShipmentData.toString()}');

    // try {
      final result = await postMethod(ApiClient.createShipmentPreview,
          body: jsonEncode(createShipmentData.toString()));
      // debugPrint('createShipmentPreview: ${result.body}');
      if(result.statusCode == 201){
        print("createShipmentPreview result body : ${json.decode(result.body)}");
        return json.decode(result.body);
      }else{
        Utils.displayErrorToast(LocaleKeys.someThingWrong.tr);
        throw CustomException(LocaleKeys.someThingWrong.tr.split(","));
      }
    // } catch (e, s) {
    //   debugPrint("we got $e $s");
    //   rethrow;
    // }
  }*/

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
