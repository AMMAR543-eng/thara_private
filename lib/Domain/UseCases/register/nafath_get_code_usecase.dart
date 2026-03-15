import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class NafathGetCodeUseCase
    extends Use_Case<Either<AppError, NafathCodeEntity>, bool?> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  NafathGetCodeUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, NafathCodeEntity>> call(bool? params) async {
    return await _registerRepositoryImpl.nafathGetCodeDomain(params);
  }
}
