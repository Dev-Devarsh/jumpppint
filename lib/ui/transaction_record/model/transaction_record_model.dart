class TransactionRecordModel {
  List<PaymentLogs>? paymentLogs;

  TransactionRecordModel({this.paymentLogs});

  TransactionRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentLogs'] != null) {
      paymentLogs = <PaymentLogs>[];
      json['paymentLogs'].forEach((v) {
        paymentLogs!.add(new PaymentLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentLogs != null) {
      data['paymentLogs'] = this.paymentLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentLogs {
  String? currency;
  String? id;
  String? expressOrderId;
  String? event;
  String? createdAt;
  int? amount;

  PaymentLogs(
      {this.currency,
        this.id,
        this.expressOrderId,
        this.event,
        this.createdAt,
        this.amount});

  PaymentLogs.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    id = json['id'];
    expressOrderId = json['expressOrderId'];
    event = json['event'];
    createdAt = json['createdAt'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['id'] = this.id;
    data['expressOrderId'] = this.expressOrderId;
    data['event'] = this.event;
    data['createdAt'] = this.createdAt;
    data['amount'] = this.amount;
    return data;
  }
}