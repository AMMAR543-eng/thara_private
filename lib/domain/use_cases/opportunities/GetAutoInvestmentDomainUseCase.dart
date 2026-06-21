import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetAutoInvestmentDomainUseCase extends Use_Case<
    Either<AppError, InvestmentConfigResponseModel>, NoParams> {
  final OpportunitiesRepository _repo;

  GetAutoInvestmentDomainUseCase(this._repo);

  @override
  Future<Either<AppError, InvestmentConfigResponseModel>> call(
    NoParams params,
  ) async {
    return await _repo.getAutoInvestmentDomain();
  }
}
