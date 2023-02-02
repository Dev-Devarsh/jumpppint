class ShipmentAddressSearchModel {
  List<AddressesSearch>? addressesSearch;

  ShipmentAddressSearchModel({this.addressesSearch});

  ShipmentAddressSearchModel.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      addressesSearch = <AddressesSearch>[];
      json['addresses'].forEach((v) {
        addressesSearch!.add(new AddressesSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressesSearch != null) {
      data['addresses'] = this.addressesSearch!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressesSearch {
  String? fullAddressEn;
  String? fullAddressChi;

  AddressesSearch({this.fullAddressEn, this.fullAddressChi});

  AddressesSearch.fromJson(Map<String, dynamic> json) {
    fullAddressEn = json['fullAddressEn'];
    fullAddressChi = json['fullAddressChi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullAddressEn'] = this.fullAddressEn;
    data['fullAddressChi'] = this.fullAddressChi;
    return data;
  }
}