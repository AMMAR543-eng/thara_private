import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ChangeEmailRequestOtpUseCase
    extends Use_Case<Either<AppError, BaseEntity>, NoParams> {
  final SettingsRepository _settingsRepositoryImpl;

  ChangeEmailRequestOtpUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(NoParams params) async {
    return await _settingsRepositoryImpl.changeEmailRequestOtpDomain();
  }
}

class ChangeEmailSubmitUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ChangeEmailSubmitParams> {
  final SettingsRepository _settingsRepositoryImpl;

  ChangeEmailSubmitUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(
      ChangeEmailSubmitParams params) async {
    return await _settingsRepositoryImpl.changeEmailSubmitDomain(
      params.email,
      params.otp,
    );
  }
}

class ChangeEmailSubmitParams extends Equatable {
  final String email;
  final String otp;

  const ChangeEmailSubmitParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
