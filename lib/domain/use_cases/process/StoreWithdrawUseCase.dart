import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class StoreWithdrawUseCase
    extends
        Use_Case<
          Either<AppError, WithdrawalResponseModel>,
          CancelWithdrawParams
        > {
  final ProcessRepository _processRepository;

  StoreWithdrawUseCase(this._processRepository);

  @override
  Future<Either<AppError, WithdrawalResponseModel>> call(
    CancelWithdrawParams params,
  ) async {
    return await _processRepository.storeWithdrawDomain(params.toJson());
  }
}
