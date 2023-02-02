import 'package:json_annotation/json_annotation.dart';
import 'package:jumppoint_app/utills/error_handler.dart';

part 'response_handler.g.dart';

@JsonSerializable()
class ResponseHandler {
  dynamic error;
  int? status;
  dynamic message;
  dynamic result;
  int httpStatus;
  String? token;

  static _isSuccess(int value) {
    return value == 200;
  }

  bool get isUnauthorised => (status == 401);

  bool get isSuccess =>
      (_isSuccess(httpStatus) && (error != null ? false : true));

  ResponseHandler(
      {this.httpStatus = 200,
      this.error,
      this.status,
      this.message,
      this.result,
      this.token});

  factory ResponseHandler.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return ResponseHandler.fromJsonHidden(json);
    } else {
      return ResponseHandler(
          status: 500,
          result: null,
          message: [],
          error: null,
          httpStatus: 500);
    }
  }

  factory ResponseHandler.fromJsonHidden(Map<String, dynamic> json) =>
      _$ResponseHandlerFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseHandlerToJson(this);
}
