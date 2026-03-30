import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetOpportunityDetailsUseCase
    extends Use_Case<Either<AppError, OpportunityDetailsEntity>, String> {
  final OpportunitiesRepository _opportunitiesRepositoryImpl;

  // Constructor
  GetOpportunityDetailsUseCase(this._opportunitiesRepositoryImpl);

  @override
  Future<Either<AppError, OpportunityDetailsEntity>> call(
    String id,
  ) async {
    return await _opportunitiesRepositoryImpl.getOpportunityDetailsDomain(id);
  }
}
