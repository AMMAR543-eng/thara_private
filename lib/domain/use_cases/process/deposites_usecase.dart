// The UseCase class for fetching TradeAccount data
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class DepositestUseCase extends Use_Case<Either<AppError, DepositeDataEntity>,
    ProcessFilterParams> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  DepositestUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, DepositeDataEntity>> call(
      ProcessFilterParams processParam) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl
        .getDepositesDomain(processParam.toJson());
  }
}
