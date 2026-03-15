import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class StoreTicketDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, StoreTicketParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  StoreTicketDomainUseCase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(StoreTicketParams params) async {
    return await _settingsRepositoryImpl.storeTicketDomain(
      params.name,
      params.phone,
      params.type,
      params.message,
    );
  }
}
