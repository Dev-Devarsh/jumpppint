class PaymentTopUpAmountOptionModel {
  Hk? hk;

  PaymentTopUpAmountOptionModel({this.hk});

  PaymentTopUpAmountOptionModel.fromJson(Map<String, dynamic> json) {
    hk = json['hk'] != null ? new Hk.fromJson(json['hk']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hk != null) {
      data['hk'] = this.hk!.toJson();
    }
    return data;
  }
}

class Hk {
  String? currency;
  List<String>? amountOptions;

  Hk({this.currency, this.amountOptions});

  Hk.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    amountOptions = json['amountOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['amountOptions'] = this.amountOptions;
    return data;
  }
}