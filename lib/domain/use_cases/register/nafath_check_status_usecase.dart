import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class NafathCheckStatusUseCase
    extends Use_Case<Either<AppError, NafathStatusModel>, bool> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  NafathCheckStatusUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, NafathStatusModel>> call(bool? isLogin) async {
    return await _registerRepositoryImpl.nafathCheckStatusDomain(isLogin);
  }
}
