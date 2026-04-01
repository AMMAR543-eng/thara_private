import '../../index/index_main.dart';

class ApiErrorModel {
  final String message;
  final int? code;
  final AccountModel? account; // ✅ new field

  ApiErrorModel({
    required this.message,
    this.code,
    this.account,
  });

  /// Factory method to handle dynamic response and return an appropriate ApiErrorModel
  factory ApiErrorModel.fromDynamic(dynamic response, {int? statusCode}) {
    if (response is String) {
      return ApiErrorModel(
        message: response,
        code: statusCode,
      );
    }

    if (response is Map<String, dynamic>) {
      final hasMessage =
          response.containsKey('message') && response['message'] is String;
      final hasErrors = response.containsKey('errors');

      if (hasErrors) {
        final errors = response['errors'];

        if (errors is Map<String, dynamic> && errors.isNotEmpty) {
          final buffer = StringBuffer();
          errors.forEach((key, value) {
            if (value is List) {
              buffer.writeln(value.join(', '));
            } else {
              buffer.writeln(value.toString());
            }
          });

          return ApiErrorModel(
            message: buffer.toString().trim(),
            code: statusCode,
            account: _parseAccount(response), // ✅ valid here
          );
        }
      }

      if (hasMessage) {
        return ApiErrorModel(
          message: response['message'],
          code: statusCode,
          account: _parseAccount(response), // ✅ valid here
        );
      }

      // ✅ If response is a Map but lacks message & errors
      return ApiErrorModel(
        message: "Unknown error format",
        code: statusCode,
        account: _parseAccount(response), // still safe here
      );
    }

    // ❌ Don't try to parse account if it's not a Map
    return ApiErrorModel(
      message: "Unexpected response format",
      code: statusCode,
    );
  }

  static AccountModel? _parseAccount(Map<String, dynamic> json) {
    final accountJson = json['account'];
    if (accountJson != null && accountJson is Map<String, dynamic>) {
      return AccountModel.fromJson(accountJson);
    }
    return null;
  }

  @override
  String toString() => message;
}
