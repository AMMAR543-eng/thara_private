// The UseCase class for fetching TradeAccount data
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class BankAddressUseCase
    extends
    Use_Case<Either<AppError, BankAddressDataEntity>, NoParams> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  BankAddressUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, BankAddressDataEntity>> call(
      NoParams param,
      ) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl.getBanksAddressDomain(
      {},
    );
  }
}
