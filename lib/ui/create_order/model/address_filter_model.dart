class AddressFilterModel {
  List<AreaRanks>? areaRanks;

  AddressFilterModel({this.areaRanks});

  AddressFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['areaRanks'] != null) {
      areaRanks = <AreaRanks>[];
      json['areaRanks'].forEach((v) {
        areaRanks!.add(new AreaRanks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.areaRanks != null) {
      data['areaRanks'] = this.areaRanks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaRanks {
  District? district;
  List<Areas>? areas;

  AreaRanks({this.district, this.areas});

  AreaRanks.fromJson(Map<String, dynamic> json) {
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(new Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class District {
  String? zh;
  String? en;

  District({this.zh, this.en});

  District.fromJson(Map<String, dynamic> json) {
    zh = json['zh'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zh'] = this.zh;
    data['en'] = this.en;
    return data;
  }
}

class Areas {
  String? zh;
  String? en;
  String? areaRank;

  Areas({this.zh, this.en, this.areaRank});

  Areas.fromJson(Map<String, dynamic> json) {
    zh = json['zh'];
    en = json['en'];
    areaRank = json['areaRank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zh'] = this.zh;
    data['en'] = this.en;
    data['areaRank'] = this.areaRank;
    return data;
  }
}