import '../../index/index_main.dart';

class SettingsService {
  // ---------------------------------------------------------------------------
  // 🔐 Change Password
  // ---------------------------------------------------------------------------
  Future<void> changePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirm,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result =
        await initUseCase(() => ChangePasswordDomainUseCase(Get.find())).call(
      ChangePasswordParams(
        oldPassword: oldPassword,
        password: password,
        passwordConfirm: passwordConfirm,
      ),
    );
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // ✉️ Change Email
  // ---------------------------------------------------------------------------
  Future<void> changeEmailRequestOtp({
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ChangeEmailRequestOtpUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> changeEmailSubmit({
    required String email,
    required String otp,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ChangeEmailSubmitUseCase(Get.find()),
    ).call(ChangeEmailSubmitParams(email: email, otp: otp));
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> verifyNewEmail({
    required String email,
    required String code,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => VerifyNewEmailDomainUseCase(Get.find()),
    ).call(VerifyNewEmailParams(email: email, code: code));
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // 📱 Change Phone
  // ---------------------------------------------------------------------------
  Future<void> changePhoneRequestOtp({
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ChangePhoneRequestOtpUseCase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> changePhoneSubmit({
    required String phone,
    required String otp,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ChangePhoneSubmitUseCase(Get.find()),
    ).call(ChangePhoneSubmitParams(phone: phone, otp: otp));

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> verifyNewPhone({
    required String phone,
    required String code,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => VerifyNewPhoneDomainUseCase(Get.find()),
    ).call(VerifyNewPhoneParams(phone: phone, code: code));

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));

    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // 🎟️ Store Ticket
  // ---------------------------------------------------------------------------
  Future<void> storeTicket({
    required String name,
    required String phone,
    required String type,
    required String message,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result =
        await initUseCase(() => StoreTicketDomainUseCase(Get.find())).call(
      StoreTicketParams(
        name: name,
        phone: phone,
        type: type,
        message: message,
      ),
    );

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // 🗑️ Delete My Profile
  // ---------------------------------------------------------------------------
  Future<void> deleteMyProfile({
    required Function(BaseEntity) voidCallBack,
    required DeactivateAccountRequest params,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => DeleteMyProfileDomainUseCase(Get.find()),
    ).call(params);

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // 📰 Articles
  // ---------------------------------------------------------------------------
  Future<void> getArticles({
    required Function(ArticleModelResponse) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ArticlesUsecase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> getArticleDetails({
    required String id,
    required Function(ArticleDetailsModelResponse) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => ArticlesDetailsUsecase(Get.find()),
    ).call(id);

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // ❓ FAQs
  // ---------------------------------------------------------------------------
  Future<void> getFaqData({required Function(FaqsData) voidCallBack}) async {
    Loader.show();
    final result = await initUseCase(
      () => FaqUsecase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ---------------------------------------------------------------------------
  // 📊 Financial Statements
  // ---------------------------------------------------------------------------
  Future<void> getFinancialStatementsData({
    required Function(FinancialStatementsData) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => FinancialStatiscUsecase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }
}
