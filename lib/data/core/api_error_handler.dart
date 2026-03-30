import 'dart:io';
import '../../index/index_main.dart';

class ErrorHandler {
  /// Handles any type of error and returns an `ApiErrorModel`
  static ApiErrorModel handle(
    dynamic error, {
    bool? fromResponse,
    int? statusCode,
  }) {
    if (error is TimeoutException) {
      return ApiErrorModel(message: "error_timeout".tr, code: 408);
    } else if (error is SocketException) {
      return ApiErrorModel(message: "error_no_connection".tr, code: 503);
    } else if (error is HttpException) {
      return ApiErrorModel(message: "error_http_failure".tr, code: 500);
    } else if (error is FormatException) {
      return ApiErrorModel(message: "error_invalid_format".tr, code: 400);
    } else if (fromResponse == true) {
      final data = handleHttpResponseError(error, statusCode ?? 0);
      return data;
    } else {
      return ApiErrorModel(message: error.toString(), code: null);
    }
  }

  static ApiErrorModel handleHttpResponseError(
    dynamic response,
    int statusCode,
  ) {
    try {
      final data = json.decode(response.body);
      if (statusCode == 401) {
        LoginResponseModel().deleteTokenLocal();
        const AccountModel().deleteAccountLocal();
        UserModel().deleteUserLocal();
        BioUserModel.deleteBioLocal();
        Get.offAllNamed(mainPage);
        return ApiErrorModel(message: "un_auth".tr, code: 0);
      }
      return ApiErrorModel.fromDynamic(data, statusCode: statusCode);
    } catch (e) {
      return ApiErrorModel(message: "error_unexpected".tr, code: statusCode);
    }
  }
}
