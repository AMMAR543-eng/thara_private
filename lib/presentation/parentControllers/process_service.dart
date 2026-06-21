import '../../index/index_main.dart';

class ProcessService {
  // Fetch Trade Account Details
  Future<void> getTradeAccount({
    required Function(TradeAccountEntity) voidCallBack,
  }) async {
    final result = await initUseCase(
      () => GetTradeAccountUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Fetch Deposit List
  Future<void> getDeposite({
    required ProcessFilterParams processParam,
    required Function(DepositeDataEntity) voidCallBack,
  }) async {
    final result = await initUseCase(
      () => DepositestUseCase(Get.find()),
    ).call(processParam);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Fetch Withdraw List
  Future<void> getWithdraws({
    required ProcessFilterParams processParam,
    required Function(WithdrawDataEntity) voidCallBack,
  }) async {
    final result = await initUseCase(
      () => GetWithdrawsUseCase(Get.find()),
    ).call(processParam);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Fetch Bank Accounts
  Future<void> getBankAccounts({
    required ProcessFilterParams processParam,
    required Function(BankAccountDataEntity) voidCallBack,
  }) async {
    final result = await initUseCase(
      () => BankAccountsUseCase(Get.find()),
    ).call(processParam);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Fetch Bank Address List
  Future<void> getBankAddresses({
    required Function(BankAddressDataEntity) voidCallBack,
  }) async {
    final result = await initUseCase(
      () => BankAddressUseCase(Get.find()),
    ).call(NoParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Store Bank Info
  Future<void> storeBank({
    required CreateBankParams params,
    required Function(SuccessModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => StoreBankUseCase(Get.find()),
    ).call(params);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Store Withdraw Request
  Future<void> storeWithdraw({
    required CancelWithdrawParams params,
    required Function(WithdrawalResponseModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => StoreWithdrawUseCase(Get.find()),
    ).call(params);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Cancel Withdraw Request
  Future<void> cancelWithdraw({
    required CancelWithdrawParams params,
    required Function(WithdrawalResponseModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => CancelWithdrawUseCase(Get.find()),
    ).call(params);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Store Bank Info with Lean
  Future<void> storeBankWithLean({
    required StoreBankWithLeanParams params,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => StoreBankWithLeanUseCase(Get.find()),
    ).call(params);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // Upgrade to Professional Investor
  Future<void> upgradeToProfessional({
    required QualifiedInvestorParamsWrapper params,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => UpgradeProfessionalUsecase(Get.find()),
    ).call(params);

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  /// ✅ NEW: Fetch Monthly Profit Summary
  Future<void> getMonthlyProfit({
    required String year,
    required Function(ProfitSummaryDataModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => MonthlyProfitUseCase(Get.find()),
    ).call(year);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  // ============================
  // 💳 WALLET PAYMENT
  // ============================

  /// Create Wallet Payment
  Future<void> createWalletPayment({
    required WalletPaymentParams params,
    required Function(CreatePaymentResponseModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
      () => CreateWalletPaymentUseCase(Get.find()),
    ).call(params);

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  /// Check Wallet Payment Status
  Future<void> checkWalletPayment({
    required String paymentId,
    required Function(CheckPaymentResponseModel) voidCallBack,
  }) async {
    final result = await initUseCase(
      () => CheckWalletPaymentUseCase(Get.find()),
    ).call(paymentId);

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }
}
