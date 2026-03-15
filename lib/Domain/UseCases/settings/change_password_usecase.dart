import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ChangePasswordDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ChangePasswordParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  ChangePasswordDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(ChangePasswordParams params) async {
    return await _settingsRepositoryImpl.changePasswordDomain(
      params.oldPassword,
      params.password,
      params.passwordConfirm,
    );
  }
}
