import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class FinancialStatiscUsecase
    extends Use_Case<Either<AppError, FinancialStatementsData>, NoParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  FinancialStatiscUsecase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, FinancialStatementsData>> call(
    NoParams params,
  ) async {
    return await _settingsRepositoryImpl.getFinancialStatementsData();
  }
}
