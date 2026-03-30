import '../../index/index_main.dart';

class ProcessRemoteDataSourceImpl extends ProcessRemoteDataSourceRepo {
  late final ClientSourceRepo _clientSoureceRepo;

  ProcessRemoteDataSourceImpl(ClientSourceRepo client) {
    _clientSoureceRepo = client;
  }

  @override
  Future<ApiResult<AccountResponse>> getTradeAccount(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.tradeAccountUrl,
      );
      final tradeAccount = AccountResponse.fromJson(response);
      return Success(tradeAccount);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<DepositeResponseModel>> getDeposites(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.deposites,
        params: data,
      );
      final model = DepositeResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<WithdrawResponseModel>> getWithdraws(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.withdraws,
        params: data,
      );
      final model = WithdrawResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<BankAccountsResponseModel>> getBankAccounts(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.bank_accounts,
        params: data,
      );
      final model = BankAccountsResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<BankAccountResponseModel>> banksAddress(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.bankAddress,
        params: data,
      );
      final model = BankAccountResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessModel>> storeBank(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.storeBank,
        params: data,
        files: files,
      );
      final model = SuccessModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<WithdrawalResponseModel>> cancelWithdraw(
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.PATCH,
        "${ApiConstatns.withdrawal_requests}$id/cancel",
        params: data,
      );
      final model = WithdrawalResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<WithdrawalResponseModel>> storeWithdraw(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.withdrawal_requests,
        params: data,
      );
      final model = WithdrawalResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> upgradeProfessional(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.upgrade_professional,
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
  Future<ApiResult<SuccessNewModel>> storeBankWithLean(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.storeBank,
        params: data,
      );
      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  /// Monthly Profit Summary
  @override
  Future<ApiResult<ProfitSummaryResponseModel>> monthlyProfit(
    Map<String, dynamic> data,
    String? year,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        "${ApiConstatns.monthlyProfitsUrl}${year ?? ''}",
        params: data,
      );
      final model = ProfitSummaryResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  // ============================
  // 💳 WALLET PAYMENT
  // ============================

  @override
  Future<ApiResult<CreatePaymentResponseModel>> createWalletPayment(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.walletPayment,
        params: data,
      );
      final model = CreatePaymentResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<CheckPaymentResponseModel>> checkWalletPayment(
    Map<String, dynamic> data,
    String paymentId,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        "${ApiConstatns.checkWalletPayment}$paymentId",
        params: data,
      );
      final model = CheckPaymentResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }
}
