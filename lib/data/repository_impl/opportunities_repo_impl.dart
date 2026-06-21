import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

class OpportunitiesRepositoryImpl extends OpportunitiesRepository {
  late final OpportunitiesRemoteDataSourceRepo
      _opportunitiesRemoteDataSourceRepo;

  OpportunitiesRepositoryImpl(this._opportunitiesRemoteDataSourceRepo);

  @override
  Future<Either<AppError, GetOpportunitiesEntity>> getOpportunitiesDomain(
    Map<String, dynamic> data,
  ) async {
    final result =
        await _opportunitiesRemoteDataSourceRepo.getOpportunities(data);

    return result is Success<OpportunitiesResponse>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, OpportunityDetailsEntity>>
      getOpportunityDetailsDomain(String opportunityId) async {
    final result = await _opportunitiesRemoteDataSourceRepo
        .getOpportunityDetails(opportunityId);

    return result is Success<OpportunityDetailsModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> subscribeToLoanDomain(
    String opportunityId,
    int volume,
  ) async {
    final result = await _opportunitiesRemoteDataSourceRepo.subscribeToLoan(
        opportunityId, volume);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> cancelSubscriptionDomain(
    String opportunityId,
  ) async {
    final result = await _opportunitiesRemoteDataSourceRepo
        .cancelSubscription(opportunityId);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, InvestmentTransactionDataEntity>> getInvestments(
    Map<String, dynamic> data,
  ) async {
    final result =
        await _opportunitiesRemoteDataSourceRepo.getInvestments(data);

    return result is Success<InvestmentTransactionDataModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ────────────────────────────────────────────────────────────────
  // 🔥 NEW AUTO-INVESTMENT METHODS
  // ────────────────────────────────────────────────────────────────

  @override
  Future<Either<AppError, InvestmentConfigResponseModel>>
      getAutoInvestmentDomain() async {
    final result = await _opportunitiesRemoteDataSourceRepo.getAutoInvestment();

    return result is Success<InvestmentConfigResponseModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> postAutoInvestmentDomain(
    Map<String, dynamic> payload,
  ) async {
    final result =
        await _opportunitiesRemoteDataSourceRepo.postAutoInvestment(payload);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  /// 🔥 NEW — Cancel Auto Investment
  @override
  Future<Either<AppError, SuccessNewModel>> cancelAutoInvestmentDomain() async {
    final result =
        await _opportunitiesRemoteDataSourceRepo.cancelAutoInvestment();

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }
}
