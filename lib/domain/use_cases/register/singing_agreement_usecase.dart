import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class singingAgreementUseCase
    extends Use_Case<Either<AppError, SingingDetailsEntity>, NoParams> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  singingAgreementUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, SingingDetailsEntity>> call(NoParams params) async {
    return await _registerRepositoryImpl.singingAgreementDomain();
  }
}
