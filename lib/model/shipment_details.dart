class ShipmentDetails {
  String? id;
  String? trackingNumber;
  String? shipmentState;
  OriginAddress? originAddress;
  DestinationAddress? destinationAddress;
  int? noOfItems;
  bool? sameDayDelivery;
  String? pickUpDate;
  String? deliveryDate;
  String? orderDate;
  String? totalCharge;
  String? paidBySender;
  String? paidByRecipent;
  List<Items>? items;

  ShipmentDetails(
      {this.id,
        this.trackingNumber,
        this.shipmentState,
        this.originAddress,
        this.destinationAddress,
        this.noOfItems,
        this.sameDayDelivery,
        this.pickUpDate,
        this.deliveryDate,
        this.orderDate,
        this.totalCharge,
        this.paidBySender,
        this.paidByRecipent,
        this.items});

  ShipmentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackingNumber = json['trackingNumber'];
    shipmentState = json['shipmentState'];
    originAddress = json['originAddress'] != null
        ? new OriginAddress.fromJson(json['originAddress'])
        : null;
    destinationAddress = json['destinationAddress'] != null
        ? new DestinationAddress.fromJson(json['destinationAddress'])
        : null;
    noOfItems = json['noOfItems'];
    sameDayDelivery = json['sameDayDelivery'];
    pickUpDate = json['pickUpDate'];
    deliveryDate = json['deliveryDate'];
    orderDate = json['orderDate'];
    totalCharge = json['totalCharge'];
    paidBySender = json['paidBySender'];
    paidByRecipent = json['paidByRecipent'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackingNumber'] = this.trackingNumber;
    data['shipmentState'] = this.shipmentState;
    if (this.originAddress != null) {
      data['originAddress'] = this.originAddress!.toJson();
    }
    if (this.destinationAddress != null) {
      data['destinationAddress'] = this.destinationAddress!.toJson();
    }
    data['noOfItems'] = this.noOfItems;
    data['sameDayDelivery'] = this.sameDayDelivery;
    data['pickUpDate'] = this.pickUpDate;
    data['deliveryDate'] = this.deliveryDate;
    data['orderDate'] = this.orderDate;
    data['totalCharge'] = this.totalCharge;
    data['paidBySender'] = this.paidBySender;
    data['paidByRecipent'] = this.paidByRecipent;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OriginAddress {
  String? contactName;
  String? contactPhone;
  String? fullAddress;
  String? floor;
  String? room;

  OriginAddress(
      {this.contactName,
        this.contactPhone,
        this.fullAddress,
        this.floor,
        this.room});

  OriginAddress.fromJson(Map<String, dynamic> json) {
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    fullAddress = json['fullAddress'];
    floor = json['floor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactName'] = this.contactName;
    data['contactPhone'] = this.contactPhone;
    data['fullAddress'] = this.fullAddress;
    data['floor'] = this.floor;
    data['room'] = this.room;
    return data;
  }
}

class DestinationAddress {
  String? contactName;
  String? contactPhone;
  String? fullAddress;
  String? floor;
  String? room;

  DestinationAddress(
      {this.contactName,
        this.contactPhone,
        this.fullAddress,
        this.floor,
        this.room});

  DestinationAddress.fromJson(Map<String, dynamic> json) {
    contactName = json['contactName'];
    contactPhone = json['contactPhone'];
    fullAddress = json['fullAddress'];
    floor = json['floor'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactName'] = this.contactName;
    data['contactPhone'] = this.contactPhone;
    data['fullAddress'] = this.fullAddress;
    data['floor'] = this.floor;
    data['room'] = this.room;
    return data;
  }
}

class Items {
  String? id;
  String? itemTrackingNumber;
  String? itemState;
  DimensionOption? dimensionOption;
  DimensionOption? weightOption;
  DimensionOption? temperatureOption;
  DimensionOption? categoryOption;
  String? actualWeight;
  String? itemNotes;

  Items(
      {this.id,
        this.itemTrackingNumber,
        this.itemState,
        this.dimensionOption,
        this.weightOption,
        this.temperatureOption,
        this.categoryOption,
        this.actualWeight,
        this.itemNotes});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemTrackingNumber = json['itemTrackingNumber'];
    itemState = json['itemState'];
    dimensionOption = json['dimensionOption'] != null
        ? new DimensionOption.fromJson(json['dimensionOption'])
        : null;
    weightOption = json['weightOption'] != null
        ? new DimensionOption.fromJson(json['weightOption'])
        : null;
    temperatureOption = json['temperatureOption'] != null
        ? new DimensionOption.fromJson(json['temperatureOption'])
        : null;
    categoryOption = json['categoryOption'] != null
        ? new DimensionOption.fromJson(json['categoryOption'])
        : null;
    actualWeight = json['actualWeight'];
    itemNotes = json['itemNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemTrackingNumber'] = this.itemTrackingNumber;
    data['itemState'] = this.itemState;
    if (this.dimensionOption != null) {
      data['dimensionOption'] = this.dimensionOption!.toJson();
    }
    if (this.weightOption != null) {
      data['weightOption'] = this.weightOption!.toJson();
    }
    if (this.temperatureOption != null) {
      data['temperatureOption'] = this.temperatureOption!.toJson();
    }
    if (this.categoryOption != null) {
      data['categoryOption'] = this.categoryOption!.toJson();
    }
    data['actualWeight'] = this.actualWeight;
    data['itemNotes'] = this.itemNotes;
    return data;
  }
}

class DimensionOption {
  String? descriptionChi;
  String? descriptionEn;

  DimensionOption({this.descriptionChi, this.descriptionEn});

  DimensionOption.fromJson(Map<String, dynamic> json) {
    descriptionChi = json['descriptionChi'];
    descriptionEn = json['descriptionEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descriptionChi'] = this.descriptionChi;
    data['descriptionEn'] = this.descriptionEn;
    return data;
  }
}
