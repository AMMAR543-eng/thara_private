import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio; // ✅ FIX
import 'package:dio/io.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:thara/index/index_main.dart';

class ClientSourceRepo {
  static const int timeoutDuration = 20;

  late dio.Dio _dio; // ✅ FIX

  ClientSourceRepo() {
    _dio = _createSecureDio();
  }

  // =========================================
  // 🔐 SSL PINNING + TIMEOUTS
  // =========================================
  dio.Dio _createSecureDio() {
    final dioClient = dio.Dio();

    (dioClient.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        final certBytes = cert.der;
        final fingerprint = sha256Convert(certBytes);

        const validFingerprints = [
          "ae2dacce880c7f3bbe708f3824f10b3e818ca8acb344156b796101fb5d81a35d",
        ];

        return validFingerprints.contains(fingerprint);
      };

      return client;
    };

    dioClient.options.connectTimeout = const Duration(seconds: timeoutDuration);
    dioClient.options.receiveTimeout = const Duration(seconds: timeoutDuration);
    dioClient.options.sendTimeout = const Duration(seconds: timeoutDuration);

    return dioClient;
  }

  // =========================================
  // 🚀 MAIN REQUEST
  // =========================================
  Future<dynamic> request(
    HttpMethod method,
    String path, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, String>? files,
    bool? auto_invest,
  }) async {
    final uri = _buildUri(path, params, method);
    headers = headers ?? await defaultHeaders();

    try {
      if (files != null && files.isNotEmpty) {
        return await _sendMultipartRequest(
          method,
          uri,
          params,
          headers,
          files,
        );
      } else {
        return await _sendRequest(
          method,
          uri,
          params,
          headers,
          auto_invest,
        );
      }
    } catch (e) {
      if (e is ApiErrorModel) throw e;
      throw ErrorHandler.handle(e);
    }
  }

  // =========================================
  // 🔵 NORMAL REQUEST
  // =========================================
  Future<dynamic> _sendRequest(
    HttpMethod method,
    Uri uri,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool? auto_invest,
  ) async {
    try {
      log("📤 ${method.name} → $uri");

      dio.Response response; // ✅ FIX

      if (auto_invest == true &&
          method != HttpMethod.GET &&
          method != HttpMethod.DELETE) {
        headers?['Content-Type'] = 'application/x-www-form-urlencoded';

        final formData = dio.FormData.fromMap(params ?? {}); // ✅ FIX

        response = await _dio.request(
          uri.toString(),
          data: formData,
          options: dio.Options(method: method.name, headers: headers), // ✅ FIX
        );
      } else {
        headers?['Content-Type'] = 'application/json';

        response = await _dio.request(
          uri.toString(),
          data: (method == HttpMethod.GET || method == HttpMethod.DELETE)
              ? null
              : params,
          queryParameters:
              (method == HttpMethod.GET || method == HttpMethod.DELETE)
                  ? params
                  : null,
          options: dio.Options(method: method.name, headers: headers), // ✅ FIX
        );
      }

      log("📥 RESPONSE (${response.statusCode}) → ${response.data}");

      return _processResponse(response);
    } catch (e) {
      if (e is dio.DioException) {
        if (e.type == dio.DioExceptionType.connectionTimeout ||
            e.type == dio.DioExceptionType.receiveTimeout ||
            e.type == dio.DioExceptionType.sendTimeout) {
          throw ApiErrorModel(
            message: "Request timeout, please try again",
            code: 408,
          );
        }
      }

      throw ErrorHandler.handle(e);
    }
  }

  // =========================================
  // 📎 MULTIPART
  // =========================================
  Future<dynamic> _sendMultipartRequest(
    HttpMethod method,
    Uri uri,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, String> files,
  ) async {
    try {
      final formData = dio.FormData(); // ✅ FIX

      if (params != null) {
        params.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      for (final entry in files.entries) {
        final file = File(entry.value);
        if (file.existsSync()) {
          formData.files.add(
            MapEntry(
              entry.key,
              await dio.MultipartFile.fromFile(entry.value), // ✅ FIX
            ),
          );
        }
      }

      final response = await _dio.request(
        uri.toString(),
        data: formData,
        options: dio.Options(method: method.name, headers: headers), // ✅ FIX
      );

      return _processResponse(response);
    } catch (e) {
      if (e is dio.DioException) {
        if (e.type == dio.DioExceptionType.connectionTimeout ||
            e.type == dio.DioExceptionType.receiveTimeout ||
            e.type == dio.DioExceptionType.sendTimeout) {
          throw ApiErrorModel(
            message: "Upload timeout, please try again",
            code: 408,
          );
        }
      }

      throw ErrorHandler.handle(e);
    }
  }

  // =========================================
  // 📥 RESPONSE HANDLER
  // =========================================
  dynamic _processResponse(dio.Response response) {
    // ✅ FIX
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response.data;
    } else {
      throw ErrorHandler.handle(
        response,
        fromResponse: true,
        statusCode: response.statusCode,
      );
    }
  }

  // =========================================
  // 🔗 URI BUILDER
  // =========================================
  Uri _buildUri(String path, Map<String, dynamic>? params, HttpMethod method) {
    const baseUrl = ApiConstatns.Base_Url;
    return Uri.parse('$baseUrl$path');
  }

  // =========================================
  // 📦 HEADERS
  // =========================================
  Future<Map<String, String>> defaultHeaders({String? tokenKey}) async {
    final String lan = LocalStorage_language().read();

    final deviceService = DeviceService();
    final deviceHeaders = await deviceService.getEncryptedHeaders();

    String platform =
        defaultTargetPlatform == TargetPlatform.android ? "android" : "ios";

    final headers = {
      'Accept': 'application/json',
      'X-PLATFORM': platform,
      'x-locale': lan,
      'X-DEVICE-ID': deviceHeaders['X-DEVICE-ID'] ?? '',
      'X-DEVICE-INFO': deviceHeaders['X-DEVICE-INFO'] ?? '',
    };

    final tokenModel = LoginResponseModel().getTokenData();
    final token = tokenModel?.data?.accessToken;

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // =========================================
  // 🔓 DECRYPT
  // =========================================
  String decryptData(String base64Encrypted) {
    const key_encryption = ApiConstatns.key_encryption;
    const inv_encryption = ApiConstatns.inv_encryption;

    final key = encrypt.Key.fromUtf8(key_encryption);
    final iv = encrypt.IV.fromUtf8(inv_encryption);

    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

    return encrypter.decrypt64(base64Encrypted, iv: iv);
  }
}

// =========================================
// 🔑 SHA256 HELPER
// =========================================
String sha256Convert(List<int> bytes) {
  final digest = sha256.convert(bytes);
  return digest.toString();
}
