import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

abstract class ProcessRepository {
  /// Fetch trade account details
  Future<Either<AppError, TradeAccountEntity>> getTradeAccountDomain(
    Map<String, dynamic> data,
  );

  /// Fetch deposit transactions
  Future<Either<AppError, DepositeDataEntity>> getDepositesDomain(
    Map<String, dynamic> data,
  );

  /// Fetch withdraw transactions
  Future<Either<AppError, WithdrawDataEntity>> getWithdrawsDomain(
    Map<String, dynamic> data,
  );

  /// Get user's saved bank accounts
  Future<Either<AppError, BankAccountDataEntity>> getBankAccountsDomain(
    Map<String, dynamic> data,
  );

  /// Get supported bank list and addresses
  Future<Either<AppError, BankAddressDataEntity>> getBanksAddressDomain(
    Map<String, dynamic> data,
  );

  /// Store new bank account
  Future<Either<AppError, SuccessModel>> storeBankDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  );

  /// Store a new withdrawal request
  Future<Either<AppError, WithdrawalResponseModel>> storeWithdrawDomain(
    Map<String, dynamic> data,
  );

  /// Store new bank with Lean integration
  Future<Either<AppError, SuccessNewModel>> storeBankWithLean(
    Map<String, dynamic> data,
  );

  /// Cancel an existing withdrawal request
  Future<Either<AppError, WithdrawalResponseModel>> cancelWithdrawDomain(
    Map<String, dynamic> data,
    String id,
  );

  /// Upload documents and data to upgrade user to a professional investor
  Future<Either<AppError, SuccessNewModel>> upgradeProfessionalDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  );

  /// Get monthly profit summary
  Future<Either<AppError, ProfitSummaryDataModel>> monthlyProfitDomain(
    Map<String, dynamic> data,
    String? year,
  );

  // ============================
  // 💳 WALLET PAYMENT
  // ============================

  /// Create wallet payment (amount + type)
  Future<Either<AppError, CreatePaymentResponseModel>>
  createWalletPaymentDomain(Map<String, dynamic> data);

  /// Check wallet payment status by payment_id
  Future<Either<AppError, CheckPaymentResponseModel>> checkWalletPaymentDomain(
    String paymentId,
  );
}
