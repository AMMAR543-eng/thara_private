// http_method.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

typedef HttpRequestFunction = Future<http.Response> Function(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
});

Future<http.Response> _getRequest(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
}) {
  return http.get(uri, headers: headers);
}

Future<http.Response> _postRequest(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
}) async {
  final request = http.MultipartRequest('POST', uri);

  if (headers != null) {
    request.headers.addAll(headers);
  }

  if (body is Map<String, dynamic>) {
    body.forEach((key, value) {
      if (value is List) {
        for (int i = 0; i < value.length; i++) {
          final item = value[i] as Map<String, dynamic>;
          item.forEach((nestedKey, nestedValue) {
            request.fields['$key[$i][$nestedKey]'] = nestedValue.toString();
          });
        }
      } else if (value is Map<String, dynamic>) {
        final item = value;
        item.forEach((nestedKey, nestedValue) {
          request.fields['$key[$nestedKey]'] = nestedValue.toString();
        });
      } else {
        request.fields[key] = value.toString();
      }
    });
  }

  final streamedResponse = await request.send();
  return http.Response.fromStream(streamedResponse);
}

Future<http.Response> _patchRequest(
  Uri uri, {
  Map<String, String>? headers,
  Object? body,
}) {
  return http.patch(
    uri,
    headers: headers,
    body: body is Map ? jsonEncode(body) : body,
  );
}

enum HttpMethod {
  GET(_getRequest),
  POST(_postRequest),
  PATCH(_patchRequest),
  PUT(_postRequest),
  DELETE(http.delete);

  final HttpRequestFunction method;

  const HttpMethod(this.method);
}
