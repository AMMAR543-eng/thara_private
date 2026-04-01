import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class RegisterVerifyOtpDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, OtpParams> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  RegisterVerifyOtpDomainUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(OtpParams params) async {
    return await _registerRepositoryImpl.verifyOtpDomain(params.code,
        url: params.url);
  }
}
