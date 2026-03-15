import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetOpportunitiesUseCase
    extends
        Use_Case<
          Either<AppError, GetOpportunitiesEntity>,
          OpportunityParameter
        > {
  final OpportunitiesRepository _opportunitiesRepositoryImpl;

  // Constructor
  GetOpportunitiesUseCase(this._opportunitiesRepositoryImpl);

  @override
  Future<Either<AppError, GetOpportunitiesEntity>> call(
    OpportunityParameter params,
  ) async {
    return await _opportunitiesRepositoryImpl.getOpportunitiesDomain(
      params.toJson(),
    );
  }
}
