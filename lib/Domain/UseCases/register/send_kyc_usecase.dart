import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class SendKycUseCase extends Use_Case<Either<AppError, BaseEntity>, KycParam> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  SendKycUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(KycParam param) async {
    return await _registerRepositoryImpl.sendKYCQuestionAnswerDomain(
      param.toJson(),
    );
  }
}
