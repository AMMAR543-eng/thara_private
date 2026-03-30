import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ResetPasswordDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ForgetParams> {
  final AuthRepository _authRepositoryImpl;

  // Constructor
  ResetPasswordDomainUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(ForgetParams params) async {
    return await _authRepositoryImpl.resetPasswordDomain(
      params.email!,
      params.nin!,
      params.code!,
      params.password!,
      params.passwordConfirm!,
    );
  }
}
