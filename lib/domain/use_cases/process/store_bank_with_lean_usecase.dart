// The UseCase class for fetching TradeAccount data
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class StoreBankWithLeanUseCase extends Use_Case<
    Either<AppError, SuccessNewModel>, StoreBankWithLeanParams> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  StoreBankWithLeanUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
    StoreBankWithLeanParams params,
  ) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl.storeBankWithLean(params.toJson());
  }
}
