class CheckOutPaymentModel {
  List<String>? paymentOptions;

  CheckOutPaymentModel({this.paymentOptions});

  CheckOutPaymentModel.fromJson(Map<String, dynamic> json) {
    paymentOptions = json['paymentOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentOptions'] = this.paymentOptions;
    return data;
  }
}