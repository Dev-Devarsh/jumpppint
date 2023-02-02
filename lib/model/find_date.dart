class FindDate {
  List<PickUpDates>? pickUpDates;
  List<String>? deliveryDates;

  FindDate({this.pickUpDates, this.deliveryDates});

  FindDate.fromJson(Map<String, dynamic> json) {
    if (json['pickUpDates'] != null) {
      pickUpDates = <PickUpDates>[];
      json['pickUpDates'].forEach((v) {
        pickUpDates!.add(new PickUpDates.fromJson(v));
      });
    }
    deliveryDates = json['deliveryDates'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickUpDates != null) {
      data['pickUpDates'] = this.pickUpDates!.map((v) => v.toJson()).toList();
    }
    data['deliveryDates'] = this.deliveryDates;
    return data;
  }
}

class PickUpDates {
  String? date;
  String? deadline;

  PickUpDates({this.date, this.deadline});

  PickUpDates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    deadline = json['deadline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['deadline'] = this.deadline;
    return data;
  }
}