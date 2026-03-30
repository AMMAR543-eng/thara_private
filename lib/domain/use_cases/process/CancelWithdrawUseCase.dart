import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class CancelWithdrawUseCase
    extends
        Use_Case<
          Either<AppError, WithdrawalResponseModel>,
          CancelWithdrawParams
        > {
  final ProcessRepository _processRepository;

  CancelWithdrawUseCase(this._processRepository);

  @override
  Future<Either<AppError, WithdrawalResponseModel>> call(
    CancelWithdrawParams params,
  ) async {
    return await _processRepository.cancelWithdrawDomain(
      params.toJson(),
      params.id.toString(),
    );
  }
}

class CancelWithdrawParams {
  final int bankAccountId;
  final String amount;
   String? id;

  CancelWithdrawParams({
    required this.bankAccountId,
    required this.amount,
     this.id,
  });

  Map<String, dynamic> toJson() {
    return {"bank_account_id": bankAccountId, "amount": amount};
  }
}
