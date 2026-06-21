import '../../index/index_main.dart';

class RegisterService {
  Future<void> getCitizenShips({
    required Function(CitizenShipsEntity) voidCallBack,
  }) async {
    //Loader.show();
    final result = await initUseCase(
      () => GetCitizenShipsUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> verifyOtp({
    String? url,
    required String code,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => RegisterVerifyOtpDomainUseCase(Get.find()),
    ).call(OtpParams(code: code, url: url));
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> resendOtp({
    String? url,
    String? withdraw_id,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => RegisterResendOtpDomainUseCase(Get.find()),
    ).call(OtpParams(url: url, code: '', withdraw_id: withdraw_id));
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> updatePassword({
    required SignUpParam param,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => UpdatePasswordUseCase(Get.find()),
    ).call(param);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> registerEmail({
    required SignUpParam param,
    required Function(LoginEntity) voidCallBack,
  }) async {
    Loader.show();
    final result =
        await initUseCase(() => RegisterEmailDomainUseCase(Get.find())).call(
      SignUpParam(
        type: param.type,
        email: param.email,
        password: param.password,
        passwordConfirm: param.passwordConfirm,
      ),
    );
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> addIndividual({
    required IndividualParam param,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => AddIndividualDomainUseCase(Get.find()),
    ).call(param);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> addCompany({
    required CompanyParam param,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => AddCompanyDomainUseCase(Get.find()),
    ).call(param);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> nafathGetCode({
    required Function(NafathCodeEntity) voidCallBack,
    bool? isLogin,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => NafathGetCodeUseCase(Get.find()),
    ).call(isLogin);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> nafathCheckStatus({
    required Function(NafathStatusModel) voidCallBack,
    required Function(AppError) errorCallback,
    bool? isLogin,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => NafathCheckStatusUseCase(Get.find()),
    ).call(isLogin);
    result.fold((l) => errorCallback(l), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> getKYCQuestions({
    required Function(KycQuestionsEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => GetKycUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> sendKYCQuestionAnswer({
    required List<KycItemEntity>? questions,
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => SendKycUseCase(Get.find()),
    ).call(KycParam(questions: questions));
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> sendKYCQuestionAnswerWithFiles({
    required List<KycItemEntity>? questions,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => SendKycWithFilesUseCase(Get.find()),
    ).call(KycParam(questions: questions));
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> signingAgreement({
    required Function(SingingDetailsEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => singingAgreementUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> singingWithSirar({
    required Function(BaseEntity) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => SingingWithSirarUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }
}
