class LabelRequestItem {
  CreateAddress createAddress = CreateAddress(address: Address());
  String? merchantRemarks;
  double? sameDayDeliveryQuantity;
  double? standardDeliveryQuantity;

  LabelRequestItem(
      {required this.createAddress,
        this.merchantRemarks,
        this.sameDayDeliveryQuantity,
        this.standardDeliveryQuantity});

  LabelRequestItem.fromJson(Map<String, dynamic> json) {
    createAddress = CreateAddress.fromJson(json['createAddress']);
    merchantRemarks = json['merchantRemarks'];
    sameDayDeliveryQuantity = json['sameDayDeliveryQuantity'];
    standardDeliveryQuantity = json['standardDeliveryQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.createAddress != null) {
      data['createAddress'] = createAddress.toJson();
    }
    data['merchantRemarks'] = merchantRemarks;
    data['sameDayDeliveryQuantity'] = sameDayDeliveryQuantity;
    data['standardDeliveryQuantity'] = standardDeliveryQuantity;
    return data;
  }
}

class Address {
  String? address;
  String? contactName;
  String? contactPhone;
  String? regionCode;
  String? floor;
  String? room;

  Address(
      {this.address,
        this.contactName,
        this.contactPhone,
        this.regionCode,
        this.floor,
        this.room});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    regionCode = json['regionCode'];
    floor = json['floor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['contactName'] = this.contactName;
    data['contactPhone'] = this.contactPhone;
    data['regionCode'] = this.regionCode;
    data['floor'] = this.floor;
    data['room'] = this.room;
    return data;
  }
}

class CreateAddress {
  Address address = Address();
  String? type;

  CreateAddress({required this.address, this.type});

  CreateAddress.fromJson(Map<String, dynamic> json) {
    address = Address.fromJson(json['address']);
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address.toJson();
    }
    data['type'] = type;
    return data;
  }
}
/*
class LabelRequestItem {
  CreateAddress? createAddress;
  String? merchantRemarks;
  double? sameDayDeliveryQuantity;
  double? standardDeliveryQuantity;

  LabelRequestItem(
      {this.createAddress,
        this.merchantRemarks,
        this.sameDayDeliveryQuantity,
        this.standardDeliveryQuantity});

  factory LabelRequestItem.fromJson(Map<String, dynamic> json) => LabelRequestItem(
    createAddress: json["createAddress"],
    merchantRemarks: json["merchantRemarks"],
    sameDayDeliveryQuantity: json["sameDayDeliveryQuantity"],
    standardDeliveryQuantity: json["standardDeliveryQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "createAddress": createAddress,
    "merchantRemarks": merchantRemarks,
    "sameDayDeliveryQuantity": sameDayDeliveryQuantity,
    "standardDeliveryQuantity": standardDeliveryQuantity,
  };
}

class CreateAddress {
  Address? address;
  String? type;

  CreateAddress({this.address, this.type});

  factory CreateAddress.fromJson(Map<String, dynamic> json) => CreateAddress(
    address: json["address"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "type": type,
  };
}

class Address {
  String? address;
  String? contactName;
  String? contactPhone;
  String? regionCode;
  String? floor;
  String? room;

  Address(
      {this.address,
        this.contactName,
        this.contactPhone,
        this.regionCode,
        this.floor,
        this.room});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    contactName: json["contactName"],
    contactPhone: json["contactPhone"],
    regionCode: json["regionCode"],
    floor: json["floor"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "contactName": contactName,
    "contactPhone": contactPhone,
    "regionCode": regionCode,
    "floor": floor,
    "room": room,
  };
}*/
