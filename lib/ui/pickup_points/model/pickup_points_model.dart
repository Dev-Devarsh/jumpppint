import 'dart:convert';

class PickupPointsModel {
  PickupPointsModel(
      {required this.pickupPointsNo,
      required this.pickupPointsTitle,
      required this.pickupPointsAddress,
      required this.isRead});

  String? pickupPointsNo;
  String? pickupPointsTitle;
  String? pickupPointsAddress;
  bool isRead = false;

  factory PickupPointsModel.fromRawJson(String str) =>
      PickupPointsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PickupPointsModel.fromJson(Map<String, dynamic> json) =>
      PickupPointsModel(
        pickupPointsNo: json["pickupPointsNo"],
        pickupPointsTitle: json["notificationTitle"],
        pickupPointsAddress: json["date"],
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "pickupPointsNo": pickupPointsNo,
        "notificationTitle": pickupPointsTitle,
        "date": pickupPointsAddress,
        "isRead": isRead,
      };
}
