class PickUpStoreOptionModel {
  bool? collectionToDoor;
  List<CollectionPickUpStore>? collectionPickUpStore;
  bool? deliveryToDoor;
  List<CollectionPickUpStore>? deliveryPickUpStore;

  PickUpStoreOptionModel(
      {this.collectionToDoor,
        this.collectionPickUpStore,
        this.deliveryToDoor,
        this.deliveryPickUpStore});

  PickUpStoreOptionModel.fromJson(Map<String, dynamic> json) {
    collectionToDoor = json['collectionToDoor'];
    if (json['collectionPickUpStore'] != null) {
      collectionPickUpStore = <CollectionPickUpStore>[];
      json['collectionPickUpStore'].forEach((v) {
        collectionPickUpStore!.add(new CollectionPickUpStore.fromJson(v));
      });
    }
    deliveryToDoor = json['deliveryToDoor'];
    if (json['deliveryPickUpStore'] != null) {
      deliveryPickUpStore = <CollectionPickUpStore>[];
      json['deliveryPickUpStore'].forEach((v) {
        deliveryPickUpStore!.add(new CollectionPickUpStore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectionToDoor'] = this.collectionToDoor;
    if (this.collectionPickUpStore != null) {
      data['collectionPickUpStore'] =
          this.collectionPickUpStore!.map((v) => v.toJson()).toList();
    }
    data['deliveryToDoor'] = this.deliveryToDoor;
    if (this.deliveryPickUpStore != null) {
      data['deliveryPickUpStore'] =
          this.deliveryPickUpStore!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionPickUpStore {
  DistrictInfo? districtInfo;
  String? code;
  String? address;
  String? alias;
  String? mondayFrom;
  String? mondayTo;
  String? tuesdayFrom;
  String? tuesdayTo;
  String? wednesdayFrom;
  String? wednesdayTo;
  String? thursdayFrom;
  String? thursdayTo;
  String? fridayFrom;
  String? fridayTo;
  String? saturdayFrom;
  String? saturdayTo;
  String? sundayFrom;
  String? sundayTo;
  String? publicHolidayFrom;
  String? publicHolidayTo;
  int? freeStorage;

  CollectionPickUpStore(
      {this.districtInfo,
        this.code,
        this.address,
        this.alias,
        this.mondayFrom,
        this.mondayTo,
        this.tuesdayFrom,
        this.tuesdayTo,
        this.wednesdayFrom,
        this.wednesdayTo,
        this.thursdayFrom,
        this.thursdayTo,
        this.fridayFrom,
        this.fridayTo,
        this.saturdayFrom,
        this.saturdayTo,
        this.sundayFrom,
        this.sundayTo,
        this.publicHolidayFrom,
        this.publicHolidayTo,
        this.freeStorage});

  CollectionPickUpStore.fromJson(Map<String, dynamic> json) {
    districtInfo = json['districtInfo'] != null
        ? new DistrictInfo.fromJson(json['districtInfo'])
        : null;
    code = json['code'];
    address = json['address'];
    alias = json['alias'];
    mondayFrom = json['mondayFrom'];
    mondayTo = json['mondayTo'];
    tuesdayFrom = json['tuesdayFrom'];
    tuesdayTo = json['tuesdayTo'];
    wednesdayFrom = json['wednesdayFrom'];
    wednesdayTo = json['wednesdayTo'];
    thursdayFrom = json['thursdayFrom'];
    thursdayTo = json['thursdayTo'];
    fridayFrom = json['fridayFrom'];
    fridayTo = json['fridayTo'];
    saturdayFrom = json['saturdayFrom'];
    saturdayTo = json['saturdayTo'];
    sundayFrom = json['sundayFrom'];
    sundayTo = json['sundayTo'];
    publicHolidayFrom = json['publicHolidayFrom'];
    publicHolidayTo = json['publicHolidayTo'];
    freeStorage = json['freeStorage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.districtInfo != null) {
      data['districtInfo'] = this.districtInfo!.toJson();
    }
    data['code'] = this.code;
    data['address'] = this.address;
    data['alias'] = this.alias;
    data['mondayFrom'] = this.mondayFrom;
    data['mondayTo'] = this.mondayTo;
    data['tuesdayFrom'] = this.tuesdayFrom;
    data['tuesdayTo'] = this.tuesdayTo;
    data['wednesdayFrom'] = this.wednesdayFrom;
    data['wednesdayTo'] = this.wednesdayTo;
    data['thursdayFrom'] = this.thursdayFrom;
    data['thursdayTo'] = this.thursdayTo;
    data['fridayFrom'] = this.fridayFrom;
    data['fridayTo'] = this.fridayTo;
    data['saturdayFrom'] = this.saturdayFrom;
    data['saturdayTo'] = this.saturdayTo;
    data['sundayFrom'] = this.sundayFrom;
    data['sundayTo'] = this.sundayTo;
    data['publicHolidayFrom'] = this.publicHolidayFrom;
    data['publicHolidayTo'] = this.publicHolidayTo;
    data['freeStorage'] = this.freeStorage;
    return data;
  }
}

class DistrictInfo {
  Area? area;
  Area? district;

  DistrictInfo({this.area, this.district});

  DistrictInfo.fromJson(Map<String, dynamic> json) {
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
    district =
    json['district'] != null ? new Area.fromJson(json['district']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    return data;
  }
}

class Area {
  String? en;
  String? zh;

  Area({this.en, this.zh});

  Area.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    zh = json['zh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['zh'] = this.zh;
    return data;
  }
}