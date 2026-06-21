import '../../index/index_main.dart';

abstract class SettingsRemoteDataSourceRepo {
  Future<ApiResult<OtpModel>> changePassword(
    String oldPassword,
    String password,
    String passwordConfirm,
  );

  Future<ApiResult<OtpModel>> changeEmailRequestOtp();

  Future<ApiResult<OtpModel>> changeEmailSubmit(String email, String otp);

  Future<ApiResult<OtpModel>> verifyNewEmail(String email, String otp);

  Future<ApiResult<OtpModel>> changePhoneRequestOtp();

  Future<ApiResult<OtpModel>> changePhoneSubmit(String phone, String otp);

  Future<ApiResult<OtpModel>> verifyNewPhone(String phone, String otp);

  Future<ApiResult<OtpModel>> storeTicket(
    String name,
    String phone,
    String type,
    String message,
  );

  Future<ApiResult<OtpModel>> deleteMyProfile(Map<String, dynamic> data);

  Future<ApiResult<FaqsData>> faqData();

  Future<ApiResult<FinancialStatementsData>> financialStatmentsData();

  Future<ApiResult<ArticleModelResponse>> articles(Map<String, dynamic> data);

  Future<ApiResult<ArticleDetailsModelResponse>> articles_details(
    Map<String, dynamic> data,
    String key,
  );
}
