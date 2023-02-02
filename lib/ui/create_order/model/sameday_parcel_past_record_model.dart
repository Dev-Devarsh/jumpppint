class SamedayParcelPastRecordModel {
  List<SamedayPreviousItems>? previousItems;

  SamedayParcelPastRecordModel({this.previousItems});

  SamedayParcelPastRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['previousItems'] != null) {
      previousItems = <SamedayPreviousItems>[];
      json['previousItems'].forEach((v) {
        previousItems!.add(new SamedayPreviousItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previousItems != null) {
      data['previousItems'] =
          this.previousItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SamedayPreviousItems {
  DimensionOption? dimensionOption;
  String? actualWeight;
  DimensionOption? weightOption;
  DimensionOption? temperatureOption;
  DimensionOption? categoryOption;
  double? category;
  int? isDocument;
  String? itemCreatedAt;

  SamedayPreviousItems(
      {this.dimensionOption,
        this.actualWeight,
        this.weightOption,
        this.temperatureOption,
        this.categoryOption,
        this.category,
        this.isDocument,
        this.itemCreatedAt});

  SamedayPreviousItems.fromJson(Map<String, dynamic> json) {
    dimensionOption = json['dimensionOption'] != null
        ? new DimensionOption.fromJson(json['dimensionOption'])
        : null;
    actualWeight = json['actualWeight'];
    weightOption = json['weightOption'] != null
        ? new DimensionOption.fromJson(json['weightOption'])
        : null;
    temperatureOption = json['temperatureOption'] != null
        ? new DimensionOption.fromJson(json['temperatureOption'])
        : null;
    categoryOption = json['categoryOption'] != null
        ? new DimensionOption.fromJson(json['categoryOption'])
        : null;
    category = json['category'];
    isDocument = json['isDocument'];
    itemCreatedAt = json['itemCreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dimensionOption != null) {
      data['dimensionOption'] = this.dimensionOption!.toJson();
    }
    data['actualWeight'] = this.actualWeight;
    if (this.weightOption != null) {
      data['weightOption'] = this.weightOption!.toJson();
    }
    if (this.temperatureOption != null) {
      data['temperatureOption'] = this.temperatureOption!.toJson();
    }
    if (this.categoryOption != null) {
      data['categoryOption'] = this.categoryOption!.toJson();
    }
    data['category'] = this.category;
    data['isDocument'] = this.isDocument;
    data['itemCreatedAt'] = this.itemCreatedAt;
    return data;
  }
}

class DimensionOption {
  String? id;
  Description? description;

  DimensionOption({this.id, this.description});

  DimensionOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'] != null
        ? new Description.fromJson(json['description'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    return data;
  }
}

class Description {
  String? en;
  String? zh;

  Description({this.en, this.zh});

  Description.fromJson(Map<String, dynamic> json) {
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