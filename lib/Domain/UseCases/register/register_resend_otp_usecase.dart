import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class RegisterResendOtpDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, OtpParams> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  RegisterResendOtpDomainUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(OtpParams params) async {
    return await _registerRepositoryImpl.resendOtpDomain(
      params.withdraw_id == null ? {} : {"id": params.withdraw_id ?? ""},
      url: params.url,
    );
  }
}
