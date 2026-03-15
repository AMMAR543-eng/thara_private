import '../../index/index_main.dart';

abstract class ProcessRemoteDataSourceRepo {
  Future<ApiResult<AccountResponse>> getTradeAccount(Map<String, dynamic> data);

  Future<ApiResult<DepositeResponseModel>> getDeposites(
    Map<String, dynamic> data,
  );

  Future<ApiResult<WithdrawResponseModel>> getWithdraws(
    Map<String, dynamic> data,
  );

  Future<ApiResult<BankAccountsResponseModel>> getBankAccounts(
    Map<String, dynamic> data,
  );

  Future<ApiResult<BankAccountResponseModel>> banksAddress(
    Map<String, dynamic> data,
  );

  Future<ApiResult<SuccessModel>> storeBank(
    Map<String, dynamic> data,
    Map<String, String> files,
  );

  Future<ApiResult<ProfitSummaryResponseModel>> monthlyProfit(
    Map<String, dynamic> data,
    String? year,
  );

  Future<ApiResult<SuccessNewModel>> storeBankWithLean(
    Map<String, dynamic> data,
  );

  Future<ApiResult<WithdrawalResponseModel>> storeWithdraw(
    Map<String, dynamic> data,
  );

  Future<ApiResult<WithdrawalResponseModel>> cancelWithdraw(
    Map<String, dynamic> data,
    String id,
  );

  Future<ApiResult<SuccessNewModel>> upgradeProfessional(
    Map<String, dynamic> data,
    Map<String, String> files,
  );

  /// create payment (amount + type)
  Future<ApiResult<CreatePaymentResponseModel>> createWalletPayment(
    Map<String, dynamic> data,
  );

  /// check payment status by payment_id
  Future<ApiResult<CheckPaymentResponseModel>> checkWalletPayment(
    Map<String, dynamic> data,
    String paymentId,
  );
}
