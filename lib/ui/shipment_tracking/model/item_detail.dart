class ItemDetailResponse{
  String itemId;
  String itemTrackingNumber;
  String createdAt;
  List<StatusLogs> statusLogs;

  ItemDetailResponse({required this.itemId,required this.itemTrackingNumber,required this.createdAt,required this.statusLogs});

  factory ItemDetailResponse.fromMap(Map<String, dynamic> json) => ItemDetailResponse(
    itemId: json["itemId"],
    itemTrackingNumber: json["itemTrackingNumber"],
    createdAt: json["createdAt"],
    statusLogs: json["statusLogs"] == null ? []
        : List<StatusLogs>.from(
        json["statusLogs"].map((x) => StatusLogs.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "itemId": itemId,
    "itemTrackingNumber": itemTrackingNumber,
    "createdAt": createdAt,
    "statusLogs": List<dynamic>.from(statusLogs.map((x) => x.toMap())),
  };
}

class StatusLogs{
  String status;
  String createdAt;

  StatusLogs({required this.status, required this.createdAt});

  factory StatusLogs.fromMap(Map<String, dynamic> json) => StatusLogs(
    status: json["status"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "createdAt": createdAt,
  };
}