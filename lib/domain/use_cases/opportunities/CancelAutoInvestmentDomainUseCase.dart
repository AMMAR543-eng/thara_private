import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class CancelAutoInvestmentDomainUseCase
    extends Use_Case<Either<AppError, SuccessNewModel>, NoParams> {

  final OpportunitiesRepository _repo;

  CancelAutoInvestmentDomainUseCase(this._repo);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
      NoParams params,
      ) async {
    return await _repo.cancelAutoInvestmentDomain();
  }
}
