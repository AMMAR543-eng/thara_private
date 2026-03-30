import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ChangeEmailDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ChangeEmailParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  ChangeEmailDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(ChangeEmailParams params) async {
    return await _settingsRepositoryImpl.changeEmailDomain(params.email);
  }
}
