import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class PostAutoInvestmentDomainUseCase extends Use_Case<
    Either<AppError, SuccessNewModel>, PostAutoInvestmentParams> {
  final OpportunitiesRepository _repo;

  PostAutoInvestmentDomainUseCase(this._repo);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
    PostAutoInvestmentParams params,
  ) async {
    return await _repo.postAutoInvestmentDomain(params.payload);
  }
}

class PostAutoInvestmentParams {
  final Map<String, dynamic> payload;

  PostAutoInvestmentParams(this.payload);
}
