import '../../index/index_main.dart';

abstract class SettingsRemoteDataSourceRepo {
  Future<ApiResult<OtpModel>> changePassword(
    String oldPassword,
    String password,
    String passwordConfirm,
  );

  Future<ApiResult<OtpModel>> changeEmail(String email);

  Future<ApiResult<OtpModel>> verifyNewEmail(String email, String otp);

  Future<ApiResult<OtpModel>> changePhone(String email);

  Future<ApiResult<OtpModel>> verifyNewPhone(String email, String otp);

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
