import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class CancelSubscriptionDomainUseCase
    extends Use_Case<Either<AppError, SuccessNewModel>, String> {
  final OpportunitiesRepository _opportunitiesRepositoryImpl;

  // Constructor
  CancelSubscriptionDomainUseCase(this._opportunitiesRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
    String opportunityId,
  ) async {
    return await _opportunitiesRepositoryImpl.cancelSubscriptionDomain(
      opportunityId,
    );
  }
}
