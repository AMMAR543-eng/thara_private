// The UseCase class for fetching TradeAccount data
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class BankAccountsUseCase
    extends
        Use_Case<Either<AppError, BankAccountDataEntity>, ProcessFilterParams> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  BankAccountsUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, BankAccountDataEntity>> call(
    ProcessFilterParams processParam,
  ) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl.getBankAccountsDomain(
      processParam.toJson(),
    );
  }
}
