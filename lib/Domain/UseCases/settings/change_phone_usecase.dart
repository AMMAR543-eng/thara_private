import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ChangePhoneDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, ChangePhoneParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  ChangePhoneDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(ChangePhoneParams params) async {
    return await _settingsRepositoryImpl.changePhoneDomain(params.phone);
  }
}


class ChangePhoneParams extends Equatable {
  final String phone;

  const ChangePhoneParams({required this.phone});

  @override
  List<Object?> get props => [phone];
}
