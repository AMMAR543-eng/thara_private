import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class DeleteMyProfileDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, DeactivateAccountRequest> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  DeleteMyProfileDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(
    DeactivateAccountRequest params,
  ) async {
    return await _settingsRepositoryImpl.deleteMyProfileDomain(params.toJson());
  }
}

class DeactivateAccountRequest {
  final String? reason;
  final String type;

  DeactivateAccountRequest({this.reason, required this.type});

  Map<String, dynamic> toJson() {
    return {"reason": reason ?? "", "type": type};
  }
}
