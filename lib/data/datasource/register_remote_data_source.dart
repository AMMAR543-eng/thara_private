import '../../index/index_main.dart';

abstract class RegisterRemoteDataSourceRepo {
  Future<ApiResult<CitizenResponseModel>> getCitizenShips();

  Future<ApiResult<OtpModel>> verifyOtp(String code, {String? url});

  Future<ApiResult<OtpModel>> resendOtp(
    Map<String, dynamic> data, {
    String? url,
  });

  Future<ApiResult<LoginResponseModel>> registerEmail(
    Map<String, dynamic> data,
  );

  Future<ApiResult<OtpModel>> addIndividual(Map<String, dynamic> data);

  Future<ApiResult<OtpModel>> addCompany(Map<String, dynamic> data);

  Future<ApiResult<NafathGetCodeModel>> nafathGetCode(bool? isLogin);

  Future<ApiResult<NafathStatusModel>> nafathCheckStatus(bool? isLogin);

  Future<ApiResult<KYCResponseModel>> getKYCQuestions();

  Future<ApiResult<OtpModel>> sendKYCQuestionAnswer(Map<String, dynamic> data);

  Future<ApiResult<SuccessNewModel>> sendKYCQuestionAnswerWithFiles(
    Map<String, dynamic> data,
    Map<String, String> files,
  );

  Future<ApiResult<SuccessNewModel>> udpate_Password(Map<String, dynamic> data);

  Future<ApiResult<SigningAgreementModel>> singingAgreementDetails();

  Future<ApiResult<OtpModel>> singingWithSirar();
}
