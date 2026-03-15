import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

class ProcessRepositoryImpl extends ProcessRepository {
  late final ProcessRemoteDataSourceRepo _processRemoteDataSourceRepo;

  ProcessRepositoryImpl(this._processRemoteDataSourceRepo);

  @override
  Future<Either<AppError, TradeAccountEntity>> getTradeAccountDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.getTradeAccount(data);

    return result is Success<AccountResponse>
        ? right(result.data.tradeAccount ?? const TradeAccountEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, DepositeDataEntity>> getDepositesDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.getDeposites(data);

    return result is Success<DepositeResponseModel>
        ? right(result.data.data ?? const DepositeDataEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, WithdrawDataEntity>> getWithdrawsDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.getWithdraws(data);

    return result is Success<WithdrawResponseModel>
        ? right(result.data.data ?? const WithdrawDataEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BankAccountDataEntity>> getBankAccountsDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.getBankAccounts(data);

    return result is Success<BankAccountsResponseModel>
        ? right(result.data.data ?? BankAccountDataEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BankAddressDataEntity>> getBanksAddressDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.banksAddress(data);

    return result is Success<BankAccountResponseModel>
        ? right(result.data.data ?? const BankAddressDataEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessModel>> storeBankDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    final result = await _processRemoteDataSourceRepo.storeBank(data, files);

    return result is Success<SuccessModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, WithdrawalResponseModel>> cancelWithdrawDomain(
    Map<String, dynamic> data,
    String id,
  ) async {
    final result = await _processRemoteDataSourceRepo.cancelWithdraw(data, id);

    return result is Success<WithdrawalResponseModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, WithdrawalResponseModel>> storeWithdrawDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.storeWithdraw(data);

    return result is Success<WithdrawalResponseModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> upgradeProfessionalDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    final result = await _processRemoteDataSourceRepo.upgradeProfessional(
      data,
      files,
    );

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> storeBankWithLean(
    Map<String, dynamic> data,
  ) async {
    final result = await _processRemoteDataSourceRepo.storeBankWithLean(data);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  /// ✅ NEW: Monthly Profit Summary
  @override
  Future<Either<AppError, ProfitSummaryDataModel>> monthlyProfitDomain(
    Map<String, dynamic> data,
    String? year,
  ) async {
    final result = await _processRemoteDataSourceRepo.monthlyProfit(data, year);

    return result is Success<ProfitSummaryResponseModel>
        ? right(result.data.data ?? ProfitSummaryDataModel())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, CreatePaymentResponseModel>>
  createWalletPaymentDomain(Map<String, dynamic> data) async {
    final result = await _processRemoteDataSourceRepo.createWalletPayment(data);

    return result is Success<CreatePaymentResponseModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, CheckPaymentResponseModel>> checkWalletPaymentDomain(
    String paymentId,
  ) async {
    final result = await _processRemoteDataSourceRepo.checkWalletPayment(
      {},
      paymentId,
    );

    return result is Success<CheckPaymentResponseModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }
}
