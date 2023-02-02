import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../connection/connection_manager.dart';
import '../exceptions/app_exception.dart';
import '../generated/locales.g.dart';
import '../logger/logger.dart';
import '../pref_keys.dart';
import '../preference/shared_preference.dart';
import '../response_handler.dart';
import 'api_client.dart';

abstract class IApiProvider {
  Future<Response<T>> postMethod<T>(String? url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress,
      bool? authCheck});

  Future<Response<T>> getMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      bool? authCheck});

  Future<Response<T>> putMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress,
      bool? authCheck});

  Future<Response<T>> patchMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress,
      bool? authCheck});

  Future<Response<T>> requestMethod<T>(String url, String method,
      {dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress,
      bool? authCheck});

  Future<Response<T>> deleteMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      bool? authCheck});

  Future<Response<T>> uploadImage<T>(String url,
      {Map<String, File?>? images,
      Map<String, dynamic>? body,
      Decoder<T>? decoder,
      bool? authCheck});
}

class ApiProviderImpl extends GetConnect implements IApiProvider {
  final ConnectionController connectionManager;
  final SharedPreferenceController sharedPreferenceController;
  final String jsonAuthenticationName = "Authorization";

  ApiProviderImpl(this.connectionManager, this.sharedPreferenceController);

  @override
  void onInit() {
    httpClient.defaultDecoder =
        (val) => ResponseHandler.fromJson(jsonDecode(val));
    httpClient.timeout = const Duration(seconds: 20);
    httpClient.baseUrl = ApiClient.baseUrl;
    httpClient.addRequestModifier<void>((request) {
      final token = sharedPreferenceController.getToken(PrefKeys.token);
      request.headers['Authorization'] = "Bearer $token";
      Logger.write('@83 we got token $token for ${request.url}');
      return request;
    });
  }

  Future<String?> _getAuthToken() async {
    String? token = await sharedPreferenceController.getToken(PrefKeys.token);
    if (token != null) {
      return token.trim();
    } else {
      return null;
    }
  }

  Future<String?> getToken() async {
    return _getAuthToken();
  }

  Future<Map<String, String>> getAuthorizedHeader() async {
    String? _token = await _getAuthToken();
    var header = <String, String>{};
    if (_token != null && _token.isNotEmpty) {
      header[jsonAuthenticationName] = 'Bearer $_token';
    }
    // ClLogger.d("Token is $_token");
    return header;
  }

  @override
  Future<Response<T>> postMethod<T>(String? url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress,
      bool? authCheck}) async {
    Logger.write("url: ${httpClient.baseUrl}$url\nrequest: $body");
    if (await connectionManager.isConnected() ?? false) {
      try {
        Response<T> response = await post<T>(
          url,
          body,
          contentType: contentType,
          headers: headers,
          decoder: decoder,
          query: query,
          uploadProgress: uploadProgress,
        ).catchError((e) {
          Logger.write('@131 post error: we got error $e');
          return Response<T>(
              statusCode: HttpStatus.badRequest,
              statusText: "Unable to complete this request. Please try again.");
        });
        Logger.write(
            "@132 Response: ${response.isOk} ${response.status.isNotFound} ${response.statusText}");
        Logger.write(
            "@134 Response: ${response.status.code} : ${response.bodyString}");
        checkAuthorize(response.status.code, authCheck);
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

  @override
  Future<Response<T>> getMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      decoder,
      bool? authCheck}) async {
    Logger.write("url: ${httpClient.baseUrl}$url");
    if (await connectionManager.isConnected() ?? false) {
      try {
        Response<T> response = await get(url,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query);
        Logger.write("@160 Response: ${response.body}");
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

  @override
  Future<Response<T>> putMethod<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress,
      bool? authCheck}) async {
    Logger.write("url: ${httpClient.baseUrl}$url\nrequest: $body");
    if (await connectionManager.isConnected() ?? false) {
      try {
        Response<T> response = await put(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        Logger.write("@190 Response: ${response.body}");
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

  @override
  Future<Response<T>> patchMethod<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress,
      bool? authCheck}) async {
    Logger.write("url: ${httpClient.baseUrl}$url\nrequest: $body");
    if (await connectionManager.isConnected() ?? false) {
      try {
        Response<T> response = await patch(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        Logger.write("@220 Response: ${response.body}");
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

  @override
  Future<Response<T>> requestMethod<T>(String url, String method,
      {body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress,
      bool? authCheck}) async {
    Logger.write("url: ${httpClient.baseUrl}$url\nrequest: $body");
    if (await connectionManager.isConnected() ?? false) {
      try {
        Response<T> response = await request(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        Logger.write("@251 Response: ${response.body}");
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

  @override
  Future<Response<T>> deleteMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      decoder,
      bool? authCheck}) async {
    Logger.write("url: ${httpClient.baseUrl}$url");
    if (await connectionManager.isConnected() ?? false) {
      try {
        Response<T> response = await delete(url,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query);
        Logger.write("Response: ${response.body}");
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

  @override
  Future<Response<T>> uploadImage<T>(String url,
      {Map<String, File?>? images,
      Map<String, dynamic>? body,
      Decoder<T>? decoder,
      bool? authCheck}) async {
    var uri = Uri.parse(url);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers.addAll(await getAuthorizedHeader());
    Logger.write("header : ${request.headers}");
    if (images != null && images.isNotEmpty) {
      for (String key in images.keys) {
        final multipartFile =
            await http.MultipartFile.fromPath(key, images[key]!.path);
        request.files.add(multipartFile);
      }
    }
    body?.forEach((key, value) {
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
    Logger.write("body is: $body");
    Logger.write("request : $request");
    final response = await http.Response.fromStream(await request
        .send()
        .timeout(const Duration(seconds: 120), onTimeout: () {
      throw CustomException(LocaleKeys.noInternetConnection.tr.split(","),
          isTimeOut: true);
    }));
    Logger.write(response.body);
    return Response(bodyString: response.body, statusCode: response.statusCode);
  }

  void checkAuthorize(int? code, bool? authCheck) {
    // if (code == 401 && (authCheck ?? true)) {
    //   throw InvalidTokenException(LocaleKeys.tokenExpire.tr);
    // }
  }
}
