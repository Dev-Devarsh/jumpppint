class ParcelItemOptionModel {
  List<ProductCategory>? category;
  List<Dimension>? dimension;
  List<Weight>? weight;
  List<Temperature>? temperature;
  List<DimensionThirdParty>? dimensionThirdParty;

  ParcelItemOptionModel(
      {this.category, this.dimension, this.weight, this.temperature, this.dimensionThirdParty});

  ParcelItemOptionModel.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <ProductCategory>[];
      json['category'].forEach((v) {
        category!.add(new ProductCategory.fromJson(v));
      });
    }
    if (json['dimension'] != null) {
      dimension = <Dimension>[];
      json['dimension'].forEach((v) {
        dimension!.add(new Dimension.fromJson(v));
      });
    }
    if (json['weight'] != null) {
      weight = <Weight>[];
      json['weight'].forEach((v) {
        weight!.add(new Weight.fromJson(v));
      });
    }
    if (json['temperature'] != null) {
      temperature = <Temperature>[];
      json['temperature'].forEach((v) {
        temperature!.add(new Temperature.fromJson(v));
      });
    }
    if (json['dimensionThirdParty'] != null) {
      dimensionThirdParty = <DimensionThirdParty>[];
      json['dimensionThirdParty'].forEach((v) {
        dimensionThirdParty!.add(new DimensionThirdParty.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.dimension != null) {
      data['dimension'] = this.dimension!.map((v) => v.toJson()).toList();
    }
    if (this.weight != null) {
      data['weight'] = this.weight!.map((v) => v.toJson()).toList();
    }
    if (this.temperature != null) {
      data['temperature'] = this.temperature!.map((v) => v.toJson()).toList();
    }
    if (this.dimensionThirdParty != null) {
      data['dimensionThirdParty'] = this.dimensionThirdParty!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategory {
  String? id;
  Description? description;

  ProductCategory({this.id, this.description});

  ProductCategory.fromJson(Map<String, dynamic> json) {
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

class Dimension {
  String? id;
  Description? description;

  Dimension({this.id, this.description});

  Dimension.fromJson(Map<String, dynamic> json) {
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

class Weight {
  String? id;
  Description? description;

  Weight({this.id, this.description});

  Weight.fromJson(Map<String, dynamic> json) {
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

class Temperature {
  String? id;
  Description? description;

  Temperature({this.id, this.description});

  Temperature.fromJson(Map<String, dynamic> json) {
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

class DimensionThirdParty {
  String? id;
  Description? description;

  DimensionThirdParty({this.id, this.description});

  DimensionThirdParty.fromJson(Map<String, dynamic> json) {
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
  String? zh;
  String? en;

  Description({this.zh, this.en});

  Description.fromJson(Map<String, dynamic> json) {
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