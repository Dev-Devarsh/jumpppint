class AreaRankResponse{
  List<AreaRanks> areaRanks;

  AreaRankResponse({required this.areaRanks});

  factory AreaRankResponse.fromMap(Map<String, dynamic> json) => AreaRankResponse(
    areaRanks: json["areaRanks"] == null ? []
        : List<AreaRanks>.from(
        json["areaRanks"].map((x) => AreaRanks.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "areaRanks": List<dynamic>.from(areaRanks.map((x) => x.toMap())),
  };
}

class AreaRanks{
  Areas district;
  List<Areas> areas;

  AreaRanks({required this.district, required this.areas});

  factory AreaRanks.fromMap(Map<String, dynamic> json) => AreaRanks(
    district: Areas.fromMap(json["district"]),
    areas: json["areas"] == null ? []
        : List<Areas>.from(
        json["areas"].map((x) => Areas.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "district": district.toMap(),
    "areas": List<dynamic>.from(areas.map((x) => x.toMap())),
  };

}

class Areas{
  String zh;
  String en;
  String? areaRank;

  Areas({required this.zh, required this.en, this.areaRank});

  factory Areas.fromMap(Map<String, dynamic> json) => Areas(
    zh: json["zh"],
    en: json["en"],
    areaRank: json["areaRank"]??"",
  );

  Map<String, dynamic> toMap() => {
    "zh": zh,
    "en": en,
    "areaRank": areaRank,
  };
}