import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class VerifyNewPhoneDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, VerifyNewPhoneParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  VerifyNewPhoneDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(VerifyNewPhoneParams params) async {
    return await _settingsRepositoryImpl.verifyNewPhoneDomain(
      params.phone,
      params.code,
    );
  }
}



class VerifyNewPhoneParams extends Equatable {
  final String phone;
  final String code;

  const VerifyNewPhoneParams({required this.phone, required this.code});

  @override
  List<Object?> get props => [phone, code];
}
