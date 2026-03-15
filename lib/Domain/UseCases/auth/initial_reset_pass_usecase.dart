import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class InitialResetPasswordDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ForgetParams> {
  final AuthRepository _authRepositoryImpl;

  // Constructor
  InitialResetPasswordDomainUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(ForgetParams params) async {
    return await _authRepositoryImpl.initialResetPasswordDomain(
      params.email!,
      params.nin!,
    );
  }
}
