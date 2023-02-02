import 'package:get/get.dart';

class ShipmentStatus {
  List<Summary>? summary;

  ShipmentStatus({this.summary});

  ShipmentStatus.fromJson(Map<String, dynamic> json) {
    if (json['summary'] != null) {
      summary = <Summary>[];
      json['summary'].forEach((v) {
        summary!.add(new Summary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? count;
  String? shipmentState;
  RxBool? isCheck = RxBool(false);

  Summary({this.count, this.shipmentState,this.isCheck});

  Summary.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    shipmentState = json['shipmentState'];
    isCheck = RxBool(false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['shipmentState'] = this.shipmentState;
    return data;
  }
}
