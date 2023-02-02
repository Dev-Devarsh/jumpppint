import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:jumppoint_app/utills/error_handler.dart';
@JsonSerializable()
class HomeResponse {
  dynamic error;
  int? status;
  String? message;
  dynamic result;
  int httpStatus;
  String? token;
  List<ShipmentRecordData>? shipmentRecordData;

  static _isSuccess(int value) {
    return value == 200;
  }

  bool get isUnauthorised => (status == 401);

  bool get isSuccess =>
      (_isSuccess(httpStatus) && (error != null ? false : true));

  HomeResponse(
      {this.httpStatus = 200,
        this.error,
        this.status,
        this.message,
        this.result,
        this.token,
        this.shipmentRecordData
      });

  factory HomeResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return HomeResponse.fromJsonHidden(json);
    } else {
      return HomeResponse(
          status: 500,
          result: null,
          message: "Unable to complete this request",
          error: null,
          httpStatus: 500,
      );
    }
  }

  factory HomeResponse.fromJsonHidden(Map<String, dynamic> json) =>
      _$ResponseHandlerFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseHandlerToJson(this);

}

HomeResponse _$ResponseHandlerFromJson(Map<String, dynamic> json) =>
    HomeResponse(
      httpStatus: json['httpStatus'] as int? ?? 200,
      error: json.containsKey("error") ? json['error'] is String ?json['error']: ErrorHandler.fromJson(json['error']) : null,
      status: json['status'] as int?,
      message: json['message'] as String?,
      result: json.containsKey('result') ? json['result'] : json,
      token: json['token'] as String?,
      shipmentRecordData: json['shipmentRecordData'] as List<ShipmentRecordData>?
    );


Map<String, dynamic> _$ResponseHandlerToJson(HomeResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
      'httpStatus': instance.httpStatus,
      'token': instance.token,
      'shipmentRecordData': instance.shipmentRecordData,
    };

List<ShipmentRecordData> shipmentRecordDataFromJson (String str) =>
    List<ShipmentRecordData>.from(json.decode(str)
        .map((e) => ShipmentRecordData.fromJson(e as Map<String, dynamic>)).toList() as List<dynamic>);

String shipmentRecordDataToJson(List<ShipmentRecordData> listData) =>
    json.encode(List<dynamic>.from(listData.map<void>((e) => e.toJson())));

class ShipmentRecordData {
  String? id;
  String? trackingNumber;
  String? shipmentState;
  OriginAddress? originAddress;
  OriginAddress? destinationAddress;
  int? noOfItems;
  bool? sameDayDelivery;
  String? totalCharge;
  String? paymentMethod;
  String? cashOnDeliveryAmount;
  String? createdAt;
  String? createdAtOld;

  ShipmentRecordData(
      {this.id,
        this.trackingNumber,
        this.shipmentState,
        this.originAddress,
        this.destinationAddress,
        this.noOfItems,
        this.sameDayDelivery,
        this.totalCharge,
        this.paymentMethod,
        this.cashOnDeliveryAmount,
        this.createdAt,
      this.createdAtOld});

  ShipmentRecordData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackingNumber = json['trackingNumber'];
    shipmentState = json['shipmentState'];
    originAddress = json['originAddress'] != null
        ? new OriginAddress.fromJson(json['originAddress'])
        : null;
    destinationAddress = json['destinationAddress'] != null
        ? new OriginAddress.fromJson(json['destinationAddress'])
        : null;
    noOfItems = json['noOfItems'];
    sameDayDelivery = json['sameDayDelivery'];
    totalCharge = json['totalCharge'];
    paymentMethod = json['paymentMethod'];
    cashOnDeliveryAmount = json['cashOnDeliveryAmount'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackingNumber'] = this.trackingNumber;
    data['shipmentState'] = this.shipmentState;
    if (this.originAddress != null) {
      data['originAddress'] = this.originAddress!.toJson();
    }
    if (this.destinationAddress != null) {
      data['destinationAddress'] = this.destinationAddress!.toJson();
    }
    data['noOfItems'] = this.noOfItems;
    data['sameDayDelivery'] = this.sameDayDelivery;
    data['totalCharge'] = this.totalCharge;
    data['paymentMethod'] = this.paymentMethod;
    data['cashOnDeliveryAmount'] = this.cashOnDeliveryAmount;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class OriginAddress {
  String? contactName;
  String? contactPhone;
  String? fullAddress;
  String? floor;
  String? room;

  OriginAddress(
      {this.contactName,
        this.contactPhone,
        this.fullAddress,
        this.floor,
        this.room});

  OriginAddress.fromJson(Map<String, dynamic> json) {
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    fullAddress = json['fullAddress'];
    floor = json['floor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactName'] = this.contactName;
    data['contactPhone'] = this.contactPhone;
    data['fullAddress'] = this.fullAddress;
    data['floor'] = this.floor;
    data['room'] = this.room;
    return data;
  }
}