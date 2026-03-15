import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class LoginDomainUseCase
    extends Use_Case<Either<AppError, LoginResponseModel>, LoginParams> {
  final AuthRepository _authRepositoryImpl;

  // Constructor
  LoginDomainUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, LoginResponseModel>> call(LoginParams params) async {
    return await _authRepositoryImpl.loginDomain(params.toJson());
  }
}
