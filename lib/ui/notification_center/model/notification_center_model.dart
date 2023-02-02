import 'dart:convert';

class NotificationCenterModel {
  NotificationCenterModel(
      {required this.notificationTitle,
      required this.date,
      required this.isRead});

  String? notificationTitle;
  String? date;
  bool isRead = false;

  factory NotificationCenterModel.fromRawJson(String str) =>
      NotificationCenterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationCenterModel.fromJson(Map<String, dynamic> json) =>
      NotificationCenterModel(
        notificationTitle: json["notificationTitle"],
        date: json["date"],
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
        "notificationTitle": notificationTitle,
        "date": date,
        "isRead": isRead,
      };
}
