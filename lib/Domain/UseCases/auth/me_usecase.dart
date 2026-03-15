import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class MeDomainUseCase extends Use_Case<Either<AppError, BaseEntity>, NoParams> {
  final AuthRepository _authRepositoryImpl;

  // Constructor
  MeDomainUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(NoParams params) async {
    return await _authRepositoryImpl.meDomain();
  }
}
