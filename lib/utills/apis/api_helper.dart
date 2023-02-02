import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../connection/connection_manager.dart';
import '../exceptions/app_exception.dart';
import '../generated/locales.g.dart';
import '../pref_keys.dart';
import '../preference/shared_preference.dart';
import '../progress_controller.dart';
import '../response_handler.dart';
import '../utils.dart';
import 'api_client.dart';

class ApiHelper {
  static String baseUrl = ApiClient.baseUrl;

  final String jsonHeaderName = ApiClient.jsonHeaderName;
  final String jsonHeaderValue = ApiClient.jsonHeaderValue;
  static String jsonAuthenticationName = ApiClient.jsonAuthenticationName;
  final int successResponse = ApiClient.successResponse;

  final ConnectionController connectionManager;
  final SharedPreferenceController sharedPreferenceController;
  final ProgressController progressController;

  ApiHelper(this.connectionManager, this.sharedPreferenceController,
      this.progressController);

  Map<String, String> getJsonHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = jsonHeaderValue;
    return header;
  }

  Future<Map<String, String>> getAuthorisedHeader() async {
    String? _token = await _getAuthToken();
    var header = getJsonHeader();
    if (_token != null && _token.isNotEmpty) {
      header[jsonAuthenticationName] = '$_token';
    }
    debugPrint("Token is $_token");
    return header;
  }

  Future<Map<String, String>> getAuthorisedFormDataHeader() async {
    String? _token = await _getAuthToken();
    var header = <String, String>{};
    if (_token != null && _token.isNotEmpty) {
      header[jsonAuthenticationName] = 'Bearer $_token';
    }
    debugPrint("Token is $_token");
    return header;
  }

  Future<String?> _getAuthToken() async {
    /*var user = await AppComponentBase.getInstance()!
        .getSharedPreference()
        .getUserDetail();
    if (user != null && user.token != null) {
      return user.token!.trim();
    } else {
      return null;
    }*/
    return "Bearer ${sharedPreferenceController.getToken(PrefKeys.token)}";
  }

  Future<http.Response> uploadImage(
      Map<String, File> images, Map<String, dynamic> body, String endPoint,
      {Map<String, String>? headers, bool closeDialogOnTimeout = true}) async {
    if (await connectionManager.isConnected() ?? false) {
      var uri = Uri.parse(baseUrl + endPoint);
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers ?? await getAuthorisedHeader());
      debugPrint("header : ${request.headers}");
      images.forEach((key, value) async {
        final multipartFile =
            await http.MultipartFile.fromPath(key, value.path);
        request.files.add(multipartFile);
      });
      body.forEach((key, value) {
        if (value is List) {
          int i = 0;
          for (var element in value) {
            request.fields['$key[$i]'] = jsonEncode(element);
            i += 1;
          }
        } else {
          request.fields[key] = value.toString();
        }
      });
      debugPrint("request : $request");
      final response = await http.Response.fromStream(await request.send())
          .timeout(const Duration(seconds: 15), onTimeout: () {
        if (closeDialogOnTimeout) {
          progressController.showProgressDialog(false);
        }

        throw CustomException(LocaleKeys.timeOutMessage.tr.split(","));
      });
      var validResp = (ResponseHandler.fromJson(json.decode(response.body)));
      if (validResp.status == ApiClient.unauthorised) {
        Utils.showUnauthorisedDialog(sharedPreferenceController);
      }
      debugPrint(response.body);
      return response;
    } else {
      throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
    }
  }

  Future<http.Response> postMethod<T>(String endPoint,
      {Map<String, String>? headers,
      dynamic body,
      Encoding? encoding,
      bool closeDialogOnTimeout = true}) async {
    headers ??= await getAuthorisedHeader();
    if (await connectionManager.isConnected() ?? false) {
      try {
        var response = await http
            .post(Uri.parse(baseUrl + endPoint),
                headers: headers, body: body, encoding: encoding)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          if (closeDialogOnTimeout) {
            progressController.showProgressDialog(false);
          }
          throw CustomException(LocaleKeys.timeOutMessage.tr);
        });
        debugPrint('response:$response');
        var validResp = (ResponseHandler.fromJson(json.decode(response.body)));
        if (validResp.status == ApiClient.unauthorised) {
          Utils.showUnauthorisedDialog(sharedPreferenceController);
        }
        debugPrint('url:${baseUrl + endPoint}');
        debugPrint('Params:${body.toString()}');
        // debugPrint('response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(LocaleKeys.noInternetConnection.tr);
        } else {}
        rethrow;
      }
    } else {
      throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
    }
  }

  Future<http.Response> getMethod<T>(String endPoint,
      {Map<String, dynamic> params = const {},
      Map<String, String>? headers,
      bool closeDialogOnTimeout = true}) async {
    headers ??= await getAuthorisedHeader();
    if (await connectionManager.isConnected() ?? false) {
      try {
        debugPrint("url:${baseUrl + endPoint}");
        debugPrint("param: ${params.toString()}");
        debugPrint("headers: ${headers.toString()}");
        Uri getUri;
        if (params.isNotEmpty) {
          Uri uri = Uri.parse(baseUrl + endPoint);
          getUri = uri.replace(queryParameters: params);
        } else {
          getUri = Uri.parse(baseUrl + endPoint);
        }

        var response = await http
            .get(getUri, headers: headers)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          if (closeDialogOnTimeout) {
            progressController.showProgressDialog(false);
          }
          throw CustomException(LocaleKeys.timeOutMessage.tr);
        });
        // debugPrint('response: ${response.body}');
        var validResp = (ResponseHandler.fromJson(json.decode(response.body)));
        if (validResp.status == ApiClient.unauthorised) {
          Utils.showUnauthorisedDialog(sharedPreferenceController);
        }
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
        }
        rethrow;
      }
    } else {
      throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
    }
  }

  Future<http.Response> deleteMethod<T>(String endPoint,
      {Map<String, dynamic> params = const {},
      Map<String, String>? headers,
      bool closeDialogOnTimeout = true}) async {
    headers ??= await getAuthorisedHeader();
    if (await connectionManager.isConnected() ?? false) {
      try {
        debugPrint("url:${baseUrl + endPoint}");
        debugPrint("param: ${params.toString()}");
        Uri getUri;
        if (params.isNotEmpty) {
          Uri uri = Uri.parse(baseUrl + endPoint);
          getUri = uri.replace(queryParameters: params);
        } else {
          getUri = Uri.parse(baseUrl + endPoint);
        }
        var response = await http
            .delete(getUri, headers: headers)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          if (closeDialogOnTimeout) {
            progressController.showProgressDialog(false);
          }
          throw CustomException(LocaleKeys.timeOutMessage.tr.split(","));
        });
        debugPrint('response: ${response.body}');
        var validResp = (ResponseHandler.fromJson(json.decode(response.body)));
        if (validResp.status == ApiClient.unauthorised) {
          Utils.showUnauthorisedDialog(sharedPreferenceController);
        }
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
        }
        rethrow;
      }
    } else {
      throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
    }
  }

  Future<http.Response> patchMethod<T>(String endPoint,
      {Map<String, String>? headers,
        dynamic body,
        Encoding? encoding,
        bool closeDialogOnTimeout = true}) async {
    headers ??= await getAuthorisedHeader();
    if (await connectionManager.isConnected() ?? false) {
      try {
        var response = await http
            .patch(Uri.parse(baseUrl + endPoint),
            headers: headers, body: body, encoding: encoding)
            .timeout(const Duration(seconds: 15), onTimeout: () {
          if (closeDialogOnTimeout) {
            progressController.showProgressDialog(false);
          }

          throw CustomException(LocaleKeys.timeOutMessage.tr.split(","));
        });
        var validResp = (ResponseHandler.fromJson(json.decode(response.body)));
        if (validResp.status == ApiClient.unauthorised) {
          Utils.showUnauthorisedDialog(sharedPreferenceController);
        }
        debugPrint('url:${baseUrl + endPoint}');
        debugPrint('Params:${body.toString()}');
        // debugPrint('response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
        } else {}
        rethrow;
      }
    } else {
      throw CustomException(LocaleKeys.noInternetConnection.tr.split(","));
    }
  }
}
