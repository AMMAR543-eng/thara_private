import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

abstract class OpportunitiesRepository {
  Future<Either<AppError, GetOpportunitiesEntity>> getOpportunitiesDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, InvestmentTransactionDataEntity>> getInvestments(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, OpportunityDetailsEntity>>
      getOpportunityDetailsDomain(String opportunityId);

  Future<Either<AppError, SuccessNewModel>> subscribeToLoanDomain(
    String opportunityId,
    int volume,
  );

  Future<Either<AppError, SuccessNewModel>> cancelSubscriptionDomain(
    String opportunityId,
  );

  /// 🔥 NEW — Get Auto Investment configuration
  Future<Either<AppError, InvestmentConfigResponseModel>>
      getAutoInvestmentDomain();

  /// 🔥 NEW — Save or Update Auto Investment configuration
  Future<Either<AppError, SuccessNewModel>> postAutoInvestmentDomain(
      Map<String, dynamic> payload);

  /// 🔥 NEW — Cancel Auto Investment configuration
  Future<Either<AppError, SuccessNewModel>> cancelAutoInvestmentDomain();
}
