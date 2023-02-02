// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_handler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseHandler _$ResponseHandlerFromJson(Map<String, dynamic> json) =>
    ResponseHandler(
      httpStatus: json['httpStatus'] as int? ?? 200,
      error: json.containsKey("error") ? json['error'] is String ?json['error']: ErrorHandler.fromJson(json['error']) : null,
      status: json['status'] as int?,
      message: json['message'] as dynamic,
      result: json.containsKey('result') ? json['result'] : json.containsKey('result') ? json['response'] : json,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ResponseHandlerToJson(ResponseHandler instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
      'httpStatus': instance.httpStatus,
      'token': instance.token,
    };
