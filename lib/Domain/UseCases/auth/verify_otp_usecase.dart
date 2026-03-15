import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class VerifyOtpDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, OtpParams> {
  final AuthRepository _authRepositoryImpl;

  // Constructor
  VerifyOtpDomainUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(OtpParams params) async {
    return await _authRepositoryImpl.verifyOtpDomain(params.code);
  }
}
