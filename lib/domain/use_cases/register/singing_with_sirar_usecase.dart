import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class SingingWithSirarUseCase
    extends Use_Case<Either<AppError, BaseEntity>, NoParams> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  SingingWithSirarUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(NoParams params) async {
    return await _registerRepositoryImpl.singingWithSirarDomain();
  }
}
