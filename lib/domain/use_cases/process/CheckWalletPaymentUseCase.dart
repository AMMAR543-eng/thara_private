// The UseCase class for checking wallet payment status
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class CheckWalletPaymentUseCase
    extends Use_Case<Either<AppError, CheckPaymentResponseModel>, String> {
  final ProcessRepository _processRepository;

  // Constructor
  CheckWalletPaymentUseCase(this._processRepository);

  @override
  Future<Either<AppError, CheckPaymentResponseModel>> call(
    String paymentId,
  ) async {
    return await _processRepository.checkWalletPaymentDomain(paymentId);
  }
}
