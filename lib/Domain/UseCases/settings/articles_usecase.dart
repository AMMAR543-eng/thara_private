import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ArticlesUsecase
    extends Use_Case<Either<AppError, ArticleModelResponse>, NoParams> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  ArticlesUsecase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, ArticleModelResponse>> call(NoParams params) async {
    return await _settingsRepositoryImpl.getArticles({});
  }
}
