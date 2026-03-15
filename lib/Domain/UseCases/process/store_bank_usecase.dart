// The UseCase class for fetching TradeAccount data
import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class StoreBankUseCase
    extends Use_Case<Either<AppError, SuccessModel>, CreateBankParams> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  StoreBankUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, SuccessModel>> call(CreateBankParams params) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl.storeBankDomain(
      params.params,
      params.files,
    );
  }
}

class CreateBankParams {
  final Map<String, dynamic> params;
  final Map<String, String> files;

  CreateBankParams({required this.params, required this.files});
}
