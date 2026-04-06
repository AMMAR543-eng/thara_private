import '../../index/index_main.dart';

class AuthService {
  // 👇 optional injection
  final LoginDomainUseCase? loginUseCase;
  final VerifyOtpDomainUseCase? verifyOtpUseCase;
  final ResendOtpDomainUseCase? resendOtpUseCase;

  AuthService({
    this.loginUseCase,
    this.verifyOtpUseCase,
    this.resendOtpUseCase,
  });

  // 👇 internal getters (production fallback)
  LoginDomainUseCase _loginUseCase() {
    return loginUseCase ??
        initUseCase(() => LoginDomainUseCase(Get.find()));
  }

  VerifyOtpDomainUseCase _verifyOtpUseCase() {
    return verifyOtpUseCase ??
        initUseCase(() => VerifyOtpDomainUseCase(Get.find()));
  }

  ResendOtpDomainUseCase _resendOtpUseCase() {
    return resendOtpUseCase ??
        initUseCase(() => ResendOtpDomainUseCase(Get.find()));
  }

  // ================================
  // LOGIN
  // ================================
  Future<void> login({
    required LoginParams params,
    required Function(LoginResponseModel) voidCallBack,
  }) async {
    Loader.show();

    final result = await _loginUseCase().call(params);

    result.fold(
          (l) => Loader.showError(l.messege),
          (r) => voidCallBack(r),
    );

    Loader.dismiss();
  }

  // ================================
  // VERIFY OTP
  // ================================
  Future<void> verifyOtp({
    required String code,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();

    final result = await _verifyOtpUseCase().call(
      OtpParams(code: code),
    );

    result.fold(
          (l) => Loader.showError(l.messege),
          (r) => voidCallBack(r),
    );

    Loader.dismiss();
  }

  // ================================
  // RESEND OTP
  // ================================
  Future<void> resendOtp({
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();

    final result = await _resendOtpUseCase().call(NoParams());

    result.fold(
          (l) => Loader.showError(l.messege),
          (r) => voidCallBack(r),
    );

    Loader.dismiss();
  }

  Future<void> me({required Function(BaseEntity) voidCallBack}) async {
    // Loader.show();
    final result = await initUseCase(
      () => MeDomainUseCase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  /// ✅ NEW: Get full user profile (personalInfo & companyInfo)
  Future<void> profileData({
    required Function(UserInfoModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ProfileDateDomainUseCase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));

    Loader.dismiss();
  }

  Future<void> logout({required Function(BaseEntity) voidCallBack}) async {
    Loader.show();
    final result = await initUseCase(
      () => LogoutDomainUseCase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> initialResetPassword({
    required String email,
    required String nin,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => InitialResetPasswordDomainUseCase(Get.find()),
    ).call(ForgetParams(email: email, nin: nin));

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> resetPassword({
    required String email,
    required String nin,
    required String code,
    required String password,
    required String passwordConfirm,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result =
        await initUseCase(() => ResetPasswordDomainUseCase(Get.find())).call(
      ForgetParams(
        email: email,
        nin: nin,
        code: code,
        password: password,
        passwordConfirm: passwordConfirm,
      ),
    );

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  /// ✅ Biometric Login
  Future<void> biometricLogin({
    required BiometricLoginParams data,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => BiometricLoginUseCase(Get.find()),
    ).call(data);

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // 🆕 Upload Profile Image
  // ---------------------------------------------------------------------------

  Future<void> uploadProfileImage({
    String? imagePath,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result =
        await initUseCase(() => UploadProfileImageUsecase(Get.find())).call(
      UploadProfileImageParamsWrapper(
        files: imagePath == null ? {} : {"profile_picture": imagePath},
      ),
    );

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));

    Loader.dismiss();
  }
}
