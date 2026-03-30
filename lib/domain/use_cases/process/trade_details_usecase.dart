// The UseCase class for fetching TradeAccount data
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetTradeAccountUseCase
    extends Use_Case<Either<AppError, TradeAccountEntity>, NoParams> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  GetTradeAccountUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, TradeAccountEntity>> call(NoParams params) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl.getTradeAccountDomain({});
  }
}
