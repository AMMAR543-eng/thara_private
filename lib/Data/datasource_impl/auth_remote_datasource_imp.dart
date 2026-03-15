import '../../index/index_main.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSourceRepo {
  late final ClientSourceRepo _clientSoureceRepo;

  AuthRemoteDataSourceImpl(ClientSourceRepo client) {
    _clientSoureceRepo = client;
  }

  @override
  Future<ApiResult<LoginResponseModel>> login(Map<String, dynamic> data) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.loginUrl,
        params: data,
      );
      final loginRes = LoginResponseModel.fromJson(response);
      loginRes.saveTokenLocal(
        saveCallback: () {
          loginRes.account?.saveAccountLocal(
            onSaved: () => print("account saved from singingWithSirar"),
          );

          loginRes.user?.saveUserLocal(
            saveCallback: () => print("account save success from otp"),
          );
        },
      );

      return Success(loginRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> uploadProfileImage(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.change_profile_photo,
        params: data,
        files: files,
      );
      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> verifyOtp(String code) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.verifyOtpUrl,
        params: {"otp": code},
      );
      final verifyRes = OtpModel.fromJson(response);
      verifyRes.account?.saveAccountLocal(
        onSaved: () => print("account saved from singingWithSirar"),
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
  Future<ApiResult<OtpModel>> resendOtp() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.resendOtpUrl,
      );
      final resendOtpRes = OtpModel.fromJson(response);
      return Success(resendOtpRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> me() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.meUrl,
      );
      final meRes = OtpModel.fromJson(response);
      return Success(meRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  /// ✅ NEW: Fetch full user profile data (with personalInfo & companyInfo)
  @override
  Future<ApiResult<UserInfoModel>> profile_date() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.profile, // 🔹 make sure this constant exists
      );

      final profileRes = UserInfoModel.fromJson(response);
      return Success(profileRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> logout() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.logoutUrl,
      );
      final logoutRes = OtpModel.fromJson(response);
      LoginResponseModel().deleteTokenLocal();
      const AccountModel().deleteAccountLocal();
      UserModel().deleteUserLocal();
      return Success(logoutRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> biometriclogin(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.BIOMETRIC,
        params: data,
      );
      final biometricRes = SuccessNewModel.fromJson(response);

      return Success(biometricRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> initialResetPassword(
    String email,
    String nin,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.initialResetPasswordUrl,
        params: {"email": email, "nin": nin},
      );
      final initResetRes = OtpModel.fromJson(response);
      return Success(initResetRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OtpModel>> resetPassword(
    String email,
    String nin,
    String code,
    String password,
    String passwordConfirm,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.resetPassword,
        params: {
          "email": email,
          "nin": nin,
          "otp": code,
          "password": password,
          "password_confirmation": passwordConfirm,
        },
      );
      final resetRes = OtpModel.fromJson(response);
      return Success(resetRes);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }
}
