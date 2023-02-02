import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ErrorHandler {
  String? name;
  String? message;
  String? header;

  ErrorHandler({this.name, this.message, this.header});

  factory ErrorHandler.fromJson(Map<String, dynamic> json) => ErrorHandler(
        name: json["name"] ?? "",
        message: json["message"] ?? "",
        header: json["header"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "message": message,
    "header": header,
  };
}
