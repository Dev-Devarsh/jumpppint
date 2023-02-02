class ShipmentAddressModel {
  List<Addresses>? addresses;

  ShipmentAddressModel({this.addresses});

  ShipmentAddressModel.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addresses {
  String? id;
  String? contactName;
  String? regionCode;
  String? contactPhone;
  String? address;
  String? floor;
  String? room;

  Addresses(
      {this.id,
        this.contactName,
        this.regionCode,
        this.contactPhone,
        this.address,
        this.floor,
        this.room});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactName = json['contactName'];
    regionCode = json['regionCode'];
    contactPhone = json['contactPhone'];
    address = json['address'];
    floor = json['floor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contactName'] = this.contactName;
    data['regionCode'] = this.regionCode;
    data['contactPhone'] = this.contactPhone;
    data['address'] = this.address;
    data['floor'] = this.floor;
    data['room'] = this.room;
    return data;
  }
}