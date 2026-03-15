import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class UpgradeProfessionalUsecase
    extends
        Use_Case<
          Either<AppError, SuccessNewModel>,
          QualifiedInvestorParamsWrapper
        > {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  UpgradeProfessionalUsecase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
    QualifiedInvestorParamsWrapper params,
  ) async {
    // Fetch trade account using the repository
    return await _processRepositoryImpl.upgradeProfessionalDomain(
      {},
      params.files,
    );
  }
}
