class UserData {
  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.languageCode,
      required this.merchant});

  final String id;
  final String name;
  final String email;
  final String phone;
  final String languageCode;
  final MerchantDetail merchant;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      languageCode: json["language_code"] ?? "",
      merchant: MerchantDetail.fromJson(json["merchant"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "language_code": languageCode,
        "merchant": merchant == null ? null : merchant.toJson(),
      };
}

class MerchantDetail {
  MerchantDetail(
      {required this.id,
      required this.name,
      required this.alias,
      required this.accountBalance,
      required this.admin});

  final String id;
  final String name;
  final String alias;
  final String accountBalance;
  final bool admin;

  factory MerchantDetail.fromJson(Map<String, dynamic> json) => MerchantDetail(
        id: json["id"].toString(),
        name: json["name"] ?? "",
        alias: json["alias"] ?? "",
        accountBalance: json["accountBalance"] ?? "",
        admin: json["admin"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alias": alias,
        "accountBalance": accountBalance,
        "admin": admin,
      };
}
