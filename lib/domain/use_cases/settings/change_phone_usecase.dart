import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ChangePhoneRequestOtpUseCase
    extends Use_Case<Either<AppError, BaseEntity>, NoParams> {
  final SettingsRepository _settingsRepositoryImpl;

  ChangePhoneRequestOtpUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(NoParams params) async {
    return await _settingsRepositoryImpl.changePhoneRequestOtpDomain();
  }
}

class ChangePhoneSubmitUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ChangePhoneSubmitParams> {
  final SettingsRepository _settingsRepositoryImpl;

  ChangePhoneSubmitUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(
      ChangePhoneSubmitParams params) async {
    return await _settingsRepositoryImpl.changePhoneSubmitDomain(
      params.phone,
      params.otp,
    );
  }
}

class ChangePhoneSubmitParams extends Equatable {
  final String phone;
  final String otp;

  const ChangePhoneSubmitParams({required this.phone, required this.otp});

  @override
  List<Object?> get props => [phone, otp];
}
