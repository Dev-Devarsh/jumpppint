import 'dart:convert';

import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ParcelModel {
  ParcelModel({
    this.trackingNo,
    this.productNature,
    this.productNatureId,
    this.dimension,
    this.dimensionId,
    this.weight,
    this.weightId,
    this.remark,
    this.temperature,
    this.temperatureId,
    required this.isExpanded,
  });

  String? trackingNo;
  String? productNature;
  String? productNatureId;
  String? dimension;
  String? dimensionId;
  String? weight;
  String? weightId;
  String? temperature;
  String? temperatureId;
  String? remark;
  RxBool isExpanded = false.obs;
  DropdownEditingController productNatureController =
      DropdownEditingController();
  DropdownEditingController dimensionController = DropdownEditingController();
  DropdownEditingController tempController = DropdownEditingController();
  DropdownEditingController weightController = DropdownEditingController();
  Rx<TextEditingController> trackingNoController =
      (TextEditingController()).obs;

  // Rx<TextEditingController> weightController = (TextEditingController()).obs;
  Rx<TextEditingController> remarkController = (TextEditingController()).obs;
  FocusNode focusTrackingNo = FocusNode();
  FocusNode focusWeight = FocusNode();
  FocusNode focusRemark = FocusNode();

  factory ParcelModel.fromRawJson(String str) =>
      ParcelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParcelModel.fromJson(Map<String, dynamic> json) => ParcelModel(
        trackingNo: json["trackingNo"],
        productNature: json["productNature"],
        productNatureId: json["productNatureId"],
        dimension: json["dimension"],
        dimensionId: json["dimensionId"],
        weight: json["weight"],
        weightId: json["weightId"],
        remark: json["remark"],
        temperature: json["temperature"],
        temperatureId: json["temperatureId"],
        isExpanded: RxBool(false),
      );

  Map<String, dynamic> toJson() => {
        "trackingNo": trackingNo,
        "productNature": productNature,
        "productNatureId": productNatureId,
        "dimension": dimension,
        "dimensionId": dimensionId,
        "weight": weight,
        "weightId": weightId,
        "remark": remark,
        "isExpanded": isExpanded,
        "temperature": temperature,
        "temperatureId": temperatureId,
      };
}
