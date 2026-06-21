import 'package:dartz/dartz.dart';

import '../../../index/index_main.dart';

class GetWithdrawsUseCase extends Use_Case<Either<AppError, WithdrawDataEntity>,
    ProcessFilterParams> {
  final ProcessRepository repository;

  GetWithdrawsUseCase(this.repository);

  @override
  Future<Either<AppError, WithdrawDataEntity>> call(
      ProcessFilterParams params) {
    return repository.getWithdrawsDomain(params.toJson());
  }
}
