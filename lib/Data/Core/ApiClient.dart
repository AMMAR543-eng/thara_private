import 'dart:convert';
import 'dart:developer'; // ✅ Added for log()
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:thara/Data/Core/header/device_info_helper.dart';
import '../../index/index_main.dart';

class ClientSourceRepo {
  static const int timeoutDuration = 20;

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
          method: method,
          uri: uri,
          params: params,
          headers: headers,
          files: files,
        );
      } else {
        return await _sendDefaultRequest(
          method,
          uri,
          params: params,
          headers: headers,
          auto_invest: auto_invest,
        );
      }
    } catch (e) {
      if (e is ApiErrorModel) throw e;
      final exception = ErrorHandler.handle(e);
      throw exception;
    }
  }

  Future<dynamic> _sendDefaultRequest(
    HttpMethod method,
    Uri uri, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    bool? auto_invest,
  }) async {
    try {
      log("📤 Sending ${method.name} → $uri");
      log("📦 Params: $params");

      // -------------------------------
      // 🔥 ONLY auto_invest_config → FORM DATA
      // -------------------------------
      if (auto_invest == true &&
          method != HttpMethod.GET &&
          method != HttpMethod.DELETE) {
        headers?['Content-Type'] = 'application/x-www-form-urlencoded';

        List<MapEntry<String, String>> entries = [];

        params?.forEach((key, value) {
          if (value is List) {
            for (int i = 0; i < value.length; i++) {
              entries.add(MapEntry("$key[$i]", value[i].toString()));
            }
          } else {
            entries.add(MapEntry(key, value.toString()));
          }
        });

        final formBody = Map<String, String>.fromEntries(entries);

        log("🔥 FINAL FORM-DATA BODY → $formBody");

        // ❗ نستخدم http.post فقط هنا
        final response = await http.post(uri, headers: headers, body: formBody);

        log(
          "📥 FORM-DATA RESPONSE (${response.statusCode}) → ${response.body}",
        );

        return _processResponse(response);
      }

      // -------------------------------
      // 🔵 All other APIs → JSON (NO CHANGES)
      // -------------------------------
      if (headers != null) headers['Content-Type'] = 'application/json';

      //  final body = jsonEncode(params ?? {});
      final body = params;

      log("📦 FINAL JSON BODY → $body");

      // نرجع نستخدم method.method كما كان في كل المشروع
      final response = await method.method(
        uri,
        headers: headers,
        body: (method == HttpMethod.GET || method == HttpMethod.DELETE)
            ? null
            : body,
      );

      log("📥 JSON RESPONSE (${response.statusCode}) → ${response.body}");

      return _processResponse(response);
    } catch (e) {
      if (e is ApiErrorModel) throw e;
      throw ErrorHandler.handle(e);
    }
  }

  Future<dynamic> _sendMultipartRequest({
    required HttpMethod method,
    required Uri uri,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    required Map<String, String> files,
  }) async {
    final request = http.MultipartRequest(method.name, uri);

    if (headers != null) request.headers.addAll(headers);

    if (kDebugMode) log("📤 Multipart Request to $uri");
    if (kDebugMode) log("📦 Headers: $headers");
    if (kDebugMode) log("📦 Params: $params");
    if (kDebugMode) log("📦 Files: $files");

    if (params != null) {
      params.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    for (final entry in files.entries) {
      final filePath = entry.value;
      final file = File(filePath);
      if (file.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath(entry.key, filePath),
        );
      } else {
        throw Exception("File not found: $filePath");
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (kDebugMode) log("📥 Multipart Status Code: ${response.statusCode}");
    if (kDebugMode) log("📥 Multipart Body: ${response.body}");

    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (kDebugMode) log('📥 Status Code: ${response.statusCode}');
    if (kDebugMode) log('📥 Response Body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        if (kDebugMode) log("❌ JSON parsing failed: $e");
        throw ApiErrorModel(
          message: "Failed to parse response",
          code: response.statusCode,
        );
      }
    } else {
      if (kDebugMode) log('❌ Error Response Detected: ${response.body}');
      throw ErrorHandler.handle(
        response,
        fromResponse: true,
        statusCode: response.statusCode,
      );
    }
  }

  Uri _buildUri(String path, Map<String, dynamic>? params, HttpMethod method) {
    const baseUrl = ApiConstatns.Base_Url;

    if (method == HttpMethod.GET || method == HttpMethod.DELETE) {
      if (params == null || params.isEmpty) {
        return Uri.parse('$baseUrl$path');
      } else {
        final query = params.entries
            .map(
              (e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
            )
            .join('&');
        return Uri.parse('$baseUrl$path?$query');
      }
    } else {
      return Uri.parse('$baseUrl$path');
    }
  }

  Future<Map<String, String>> defaultHeaders({String? tokenKey}) async {
    final String lan = LocalStorage_language().read();

    final deviceService = DeviceService();
    final deviceHeaders = await deviceService.getEncryptedHeaders();

    String platform = defaultTargetPlatform == TargetPlatform.android
        ? "android"
        : "ios";

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

    if (kDebugMode) {
      log('🔍 Header: ${headers}');
      log('🔍 Decrypted DEVICE ID: ${decryptData(headers["X-DEVICE-ID"]!)}');
      log(
        '🔍 Decrypted DEVICE INFO: ${decryptData(headers["X-DEVICE-INFO"]!)}',
      );
      log('🛡️ Auth Token: $token');
    }

    return headers;
  }

  String decryptData(String base64Encrypted) {
    const key_encryption = ApiConstatns.key_encryption;
    const inv_encryption = ApiConstatns.inv_encryption;
    final key = encrypt.Key.fromUtf8(key_encryption);
    final iv = encrypt.IV.fromUtf8(inv_encryption);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
    return encrypter.decrypt64(base64Encrypted, iv: iv);
  }
}
