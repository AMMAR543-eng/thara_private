import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ArticlesDetailsUsecase
    extends Use_Case<Either<AppError, ArticleDetailsModelResponse>, String> {
  final SettingsRepository _settingsRepositoryImpl;

  // Constructor
  ArticlesDetailsUsecase(this._settingsRepositoryImpl);

  @override
  Future<Either<AppError, ArticleDetailsModelResponse>> call(String id) async {
    return await _settingsRepositoryImpl.getArticleDetails({}, id);
  }
}
