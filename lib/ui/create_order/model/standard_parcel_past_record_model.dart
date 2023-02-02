class StandardParcelPastRecordModel {
  List<StandardPreviousItems>? previousItems;

  StandardParcelPastRecordModel({this.previousItems});

  StandardParcelPastRecordModel.fromJson(Map<String, dynamic> json) {
    if (json['previousItems'] != null) {
      previousItems = <StandardPreviousItems>[];
      json['previousItems'].forEach((v) {
        previousItems!.add(new StandardPreviousItems.fromJson(v));
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

class StandardPreviousItems {
  CategoryOption? categoryOption;
  String? category;
  CategoryOption? dimensionOption;
  CategoryOption? temperatureOption;
  CategoryOption? weightOption;
  double? actualWeight;
  bool? isDocument;
  String? itemCreatedAt;

  StandardPreviousItems(
      {this.categoryOption,
        this.category,
        this.dimensionOption,
        this.temperatureOption,
        this.weightOption,
        this.actualWeight,
        this.isDocument,
        this.itemCreatedAt});

  StandardPreviousItems.fromJson(Map<String, dynamic> json) {
    categoryOption = json['categoryOption'] != null
        ? new CategoryOption.fromJson(json['categoryOption'])
        : null;
    category = json['category'];
    dimensionOption = json['dimensionOption'] != null
        ? new CategoryOption.fromJson(json['dimensionOption'])
        : null;
    temperatureOption = json['temperatureOption'] != null
        ? new CategoryOption.fromJson(json['temperatureOption'])
        : null;
    weightOption = json['weightOption'] != null
        ? new CategoryOption.fromJson(json['weightOption'])
        : null;
    actualWeight = json['actualWeight'];
    isDocument = json['isDocument'];
    itemCreatedAt = json['itemCreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryOption != null) {
      data['categoryOption'] = this.categoryOption!.toJson();
    }
    data['category'] = this.category;
    if (this.dimensionOption != null) {
      data['dimensionOption'] = this.dimensionOption!.toJson();
    }
    if (this.temperatureOption != null) {
      data['temperatureOption'] = this.temperatureOption!.toJson();
    }
    if (this.weightOption != null) {
      data['weightOption'] = this.weightOption!.toJson();
    }
    data['actualWeight'] = this.actualWeight;
    data['isDocument'] = this.isDocument;
    data['itemCreatedAt'] = this.itemCreatedAt;
    return data;
  }
}

class CategoryOption {
  String? id;
  Description? description;

  CategoryOption({this.id, this.description});

  CategoryOption.fromJson(Map<String, dynamic> json) {
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
  Zh? zh;
  Zh? en;

  Description({this.zh, this.en});

  Description.fromJson(Map<String, dynamic> json) {
    zh = json['zh'] != null ? new Zh.fromJson(json['zh']) : null;
    en = json['en'] != null ? new Zh.fromJson(json['en']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.zh != null) {
      data['zh'] = this.zh!.toJson();
    }
    if (this.en != null) {
      data['en'] = this.en!.toJson();
    }
    return data;
  }
}

class Zh {
  String? value;

  Zh({this.value});

  Zh.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}