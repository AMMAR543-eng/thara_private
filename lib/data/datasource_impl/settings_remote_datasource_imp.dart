import 'package:dio/dio.dart';
import '../../index/index_main.dart';

class SettingsRemoteDataSourceImpl extends SettingsRemoteDataSourceRepo {
  late final ClientSourceRepo _clientSoureceRepo;

  SettingsRemoteDataSourceImpl(ClientSourceRepo client) {
    _clientSoureceRepo = client;
  }

  // ---------------------------------------------------------------------------
  // 🔐 Password
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<OtpModel>> changePassword(
    String oldPassword,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.changePassword,
        params: {
          "old_password": oldPassword,
          "password": password,
          "password_confirmation": passwordConfirm,
        },
      );
      final changePasswordRes = OtpModel.fromJson(response);
      return Success(changePasswordRes);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // ✉️ Email
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<OtpModel>> changeEmailRequestOtp() async {
    try {
      debugPrint('✉️ [changeEmailRequestOtp] URL: ${ApiConstatns.changeEmailRequestOtp}');
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.changeEmailRequestOtp,
        params: {},
      );
      debugPrint('✉️ [changeEmailRequestOtp] response: $response');
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      debugPrint('✉️ [changeEmailRequestOtp] ERROR: $error');
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<OtpModel>> changeEmailSubmit(String email, String otp) async {
    try {
      debugPrint('✉️ [changeEmailSubmit] URL: ${ApiConstatns.changeEmailSubmit}');
      debugPrint('✉️ [changeEmailSubmit] params: {"email": "$email", "code": "$otp"}');
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.changeEmailSubmit,
        params: {"email": email, "code": otp},
      );
      debugPrint('✉️ [changeEmailSubmit] response: $response');
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      debugPrint('✉️ [changeEmailSubmit] ERROR: $error');
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<OtpModel>> verifyNewEmail(String email, String otp) async {
    try {
      debugPrint('✉️ [verifyNewEmail] URL: ${ApiConstatns.verifyEmail}');
      debugPrint('✉️ [verifyNewEmail] params: {"email": "$email", "otp": "$otp"}');
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.verifyEmail,
        params: {"email": email, "otp": otp},
      );
      debugPrint('✉️ [verifyNewEmail] response: $response');
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      debugPrint('✉️ [verifyNewEmail] ERROR: $error');
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // 📱 Phone
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<OtpModel>> changePhoneRequestOtp() async {
    try {
      debugPrint('📱 [changePhoneRequestOtp] URL: ${ApiConstatns.changePhoneRequestOtp}');
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.changePhoneRequestOtp,
        params: {},
      );
      debugPrint('📱 [changePhoneRequestOtp] response: $response');
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      debugPrint('📱 [changePhoneRequestOtp] ERROR: $error');
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<OtpModel>> changePhoneSubmit(String phone, String otp) async {
    try {
      debugPrint('📱 [changePhoneSubmit] URL: ${ApiConstatns.changePhoneSubmit}');
      debugPrint('📱 [changePhoneSubmit] params: {"phone": "$phone", "code": "$otp"}');
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.changePhoneSubmit,
        params: {"phone": phone, "code": otp},
      );
      debugPrint('📱 [changePhoneSubmit] response: $response');
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      debugPrint('📱 [changePhoneSubmit] ERROR: $error');
      if (error is DioException) {
        debugPrint('📱 [changePhoneSubmit] RESPONSE BODY: ${error.response?.data}');
      }
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<OtpModel>> verifyNewPhone(String phone, String otp) async {
    try {
      debugPrint('📱 [verifyNewPhone] URL: ${ApiConstatns.verifyPhone}');
      debugPrint('📱 [verifyNewPhone] params: {"phone": "$phone", "otp": "$otp"}');
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.verifyPhone,
        params: {"phone": phone, "otp": otp},
      );
      debugPrint('📱 [verifyNewPhone] response: $response');
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      debugPrint('📱 [verifyNewPhone] ERROR: $error');
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // 🎟️ Support Ticket
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<OtpModel>> storeTicket(
    String name,
    String phone,
    String type,
    String message,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.storeTicket,
        params: {
          "name": name,
          "phone_number": phone,
          "type": type,
          "message": message,
        },
      );
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // 🗑️ Delete Account
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<OtpModel>> deleteMyProfile(Map<String, dynamic> data) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        params: data,
        ApiConstatns.deleteMyProfile,
      );
      final result = OtpModel.fromJson(response);
      return Success(result);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // 📰 Articles
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<ArticleModelResponse>> articles(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.article,
      );
      final result = ArticleModelResponse.fromJson(response);
      return Success(result);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<ArticleDetailsModelResponse>> articles_details(
    Map<String, dynamic> data,
    String key,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        "${ApiConstatns.article}/$key",
      );
      final result = ArticleDetailsModelResponse.fromJson(response);
      return Success(result);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // ❓ FAQs
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<FaqsData>> faqData() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.faq,
      );
      final result = FaqsResponseModel.fromJson(response);
      return Success(result.data ?? FaqsData());
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ---------------------------------------------------------------------------
  // 📊 Financial Statements
  // ---------------------------------------------------------------------------

  @override
  Future<ApiResult<FinancialStatementsData>> financialStatmentsData() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.finicial,
      );
      final result = FinancialStatementsResponseModel.fromJson(response);
      return Success(result.data ?? FinancialStatementsData());
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }
}
