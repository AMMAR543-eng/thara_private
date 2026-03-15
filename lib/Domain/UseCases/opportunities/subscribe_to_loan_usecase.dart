import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class SubscribeToLoanDomainUseCase
    extends
        Use_Case<
          Either<AppError, SuccessNewModel>,
          InvestSubscribeParam
        > {
  final OpportunitiesRepository _opportunitiesRepositoryImpl;

  // Constructor
  SubscribeToLoanDomainUseCase(this._opportunitiesRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
    InvestSubscribeParam params,
  ) async {
    return await _opportunitiesRepositoryImpl.subscribeToLoanDomain(
      params.oppo_id,
      params.value,
    );
  }
}

class InvestSubscribeParam {
  final String oppo_id;
  final int value;

  InvestSubscribeParam(this.oppo_id, this.value);
}
