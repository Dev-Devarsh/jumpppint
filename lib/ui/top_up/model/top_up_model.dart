import 'dart:convert';

class TopUpModel {
  TopUpModel(
      {required this.name,
      required this.cardNumber,
      required this.expiryDate,
      required this.cardType});

  String? name;
  String? cardNumber;
  String? expiryDate;
  int cardType;

  factory TopUpModel.fromRawJson(String str) =>
      TopUpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopUpModel.fromJson(Map<String, dynamic> json) => TopUpModel(
        name: json["name"],
        cardNumber: json["cardNumber"],
        expiryDate: json["expiryDate"],
        cardType: json["cardType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cardNumber": cardNumber,
        "expiryDate": expiryDate,
        "cardType": cardType,
      };
}
