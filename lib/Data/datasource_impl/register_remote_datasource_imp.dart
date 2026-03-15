import '../../index/index_main.dart';

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSourceRepo {
  late final ClientSourceRepo _clientSoureceRepo;

  RegisterRemoteDataSourceImpl(ClientSourceRepo client) {
    _clientSoureceRepo = client;
  }

  @override
  Future<ApiResult<CitizenResponseModel>> getCitizenShips() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.citizenShips,
      );
      final citizenShipsItems = CitizenResponseModel.fromJson(response);
      return Success(citizenShipsItems);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> verifyOtp(String code, {String? url}) async {
    try {
      final response = await _clientSoureceRepo.request(
        url != null ? HttpMethod.PATCH : HttpMethod.POST,
        url ?? ApiConstatns.registerVerifyOtp,
        params: {"otp": code},
      );
      final verifyRes = OtpModel.fromJson(response);
      verifyRes.account?.saveAccountLocal(
        onSaved: () => print("account save success from otp"),
      );
      verifyRes.user?.saveUserLocal(
        saveCallback: () => print("account save success from otp"),
      );
      return Success(verifyRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> resendOtp(
    Map<String, dynamic> data, {
    String? url,
  }) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        url ?? ApiConstatns.registerResendOtp,
        params: data,
      );
      final resendOtpRes = OtpModel.fromJson(response);
      return Success(resendOtpRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<LoginResponseModel>> registerEmail(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.registerEmail,
        params: data,
      );
      final registerEmailRes = LoginResponseModel.fromJson(response);

      registerEmailRes.saveTokenLocal(
        saveCallback: () => print("token saved success to local"),
      );

      registerEmailRes.account?.saveAccountLocal(
        onSaved: () => print("account saved from registerEmail"),
      );

      registerEmailRes.user?.saveUserLocal(
        saveCallback: () => print("account save success from otp"),
      );

      return Success(registerEmailRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> addIndividual(Map<String, dynamic> data) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.registerBasicInfo,
        params: data,
      );
      final addIndividualRes = OtpModel.fromJson(response);
      addIndividualRes.account?.saveAccountLocal(
        onSaved: () => print("account saved from addIndividual"),
      );
      addIndividualRes.user?.saveUserLocal(
        saveCallback: () => print("account save success from otp"),
      );
      return Success(addIndividualRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> addCompany(Map<String, dynamic> data) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.registerBasicInfo,
        params: data,
      );
      final addCompanyRes = OtpModel.fromJson(response);
      addCompanyRes.account?.saveAccountLocal(
        onSaved: () => print("account saved from addCompany"),
      );
      addCompanyRes.user?.saveUserLocal(
        saveCallback: () => print("account save success from otp"),
      );
      return Success(addCompanyRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<NafathGetCodeModel>> nafathGetCode(bool? isLogin) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        isLogin == true
            ? ApiConstatns.nafathLoginGetCode
            : ApiConstatns.nafathGetCode,
      );
      final nafathCodeRes = NafathGetCodeModel.fromJson(response);
      return Success(nafathCodeRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<NafathStatusModel>> nafathCheckStatus(bool? isLogin) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        isLogin == true
            ? ApiConstatns.nafathLoginCheckStatus
            : ApiConstatns.nafathCheckStatus,
      );
      final nafathStatusRes = NafathStatusModel.fromJson(response);
      return Success(nafathStatusRes);
    } catch (error) {
      final handledError = error is ApiErrorModel
          ? error
          : ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<KYCResponseModel>> getKYCQuestions() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.registerKYCQuestions,
      );
      final getKycQuestionsRes = KYCResponseModel.fromJson(response);
      return Success(getKycQuestionsRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> sendKYCQuestionAnswer(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.registerKYCQuestions,
        params: data,
      );
      final sendKycQuestionsRes = OtpModel.fromJson(response);
      sendKycQuestionsRes.account?.saveAccountLocal(
        onSaved: () => print("account saved from sendKYCQuestionAnswer"),
      );

      sendKycQuestionsRes.user?.saveUserLocal(
        saveCallback: () => print("account save success from otp"),
      );
      return Success(sendKycQuestionsRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SingingAgreementModel>> singingAgreementDetails() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.singingAgreementDetails,
      );
      final singingAgreementRes = SingingAgreementModel.fromJson(response);
      return Success(singingAgreementRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> singingWithSirar() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.singingWithSirar,
      );
      final singingWithSirarRes = OtpModel.fromJson(response);
      singingWithSirarRes.account?.saveAccountLocal(
        onSaved: () => print("account saved from singingWithSirar"),
      );

      singingWithSirarRes.user?.saveUserLocal(
        saveCallback: () => print("account save success from otp"),
      );

      return Success(singingWithSirarRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> udpate_Password(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.PATCH,
        ApiConstatns.udpdatePassword,
        params: data,
      );
      final successModel = SuccessNewModel.fromJson(response);
      return Success(successModel);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> sendKYCQuestionAnswerWithFiles(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.registerKYCQuestions,
        params: data,
        files: files,
      );
      final successModel = SuccessNewModel.fromJson(response);
      return Success(successModel);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }
}
