class PaymentTopUpModel {
  List<PaymentMethods>? paymentMethods;

  PaymentTopUpModel({this.paymentMethods});

  PaymentTopUpModel.fromJson(Map<String, dynamic> json) {
    if (json['paymentMethods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['paymentMethods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethods != null) {
      data['paymentMethods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethods {
  String? id;
  String? status;
  Null? requiresCvc;
  String? createdAt;
  PaymentMethodData? paymentMethod;

  PaymentMethods(
      {this.id,
        this.status,
        this.requiresCvc,
        this.createdAt,
        this.paymentMethod});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    requiresCvc = json['requiresCvc'];
    createdAt = json['createdAt'];
    paymentMethod = json['paymentMethod'] != null
        ? new PaymentMethodData.fromJson(json['paymentMethod'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['requiresCvc'] = this.requiresCvc;
    data['createdAt'] = this.createdAt;
    if (this.paymentMethod != null) {
      data['paymentMethod'] = this.paymentMethod!.toJson();
    }
    return data;
  }
}

class PaymentMethodData {
  String? id;
  String? type;
  String? brand;
  String? name;
  String? last4;
  String? expiryMonth;
  String? expiryYear;

  PaymentMethodData(
      {this.id,
        this.type,
        this.brand,
        this.name,
        this.last4,
        this.expiryMonth,
        this.expiryYear});

  PaymentMethodData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    brand = json['brand'];
    name = json['name'];
    last4 = json['last4'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['last4'] = this.last4;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;
    return data;
  }
}