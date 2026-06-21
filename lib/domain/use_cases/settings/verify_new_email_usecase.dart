import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class VerifyNewEmailDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, VerifyNewEmailParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  VerifyNewEmailDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(VerifyNewEmailParams params) async {
    return await _settingsRepositoryImpl.verifyNewEmailDomain(
      params.email,
      params.code,
    );
  }
}
