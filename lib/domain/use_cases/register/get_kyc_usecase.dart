import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetKycUseCase
    extends Use_Case<Either<AppError, KycQuestionsEntity>, NoParams> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  GetKycUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, KycQuestionsEntity>> call(NoParams params) async {
    return await _registerRepositoryImpl.getKYCQuestionsDomain();
  }
}
