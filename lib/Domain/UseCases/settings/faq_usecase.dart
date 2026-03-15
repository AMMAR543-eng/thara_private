import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class FaqUsecase extends Use_Case<Either<AppError, FaqsData>, NoParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  FaqUsecase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, FaqsData>> call(NoParams params) async {
    return await _settingsRepositoryImpl.getFaqData();
  }
}
