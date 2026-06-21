import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class RegisterEmailDomainUseCase
    extends Use_Case<Either<AppError, LoginEntity>, SignUpParam> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  RegisterEmailDomainUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, LoginEntity>> call(SignUpParam params) async {
    return await _registerRepositoryImpl.registerEmailDomain(params.toJson());
  }
}
