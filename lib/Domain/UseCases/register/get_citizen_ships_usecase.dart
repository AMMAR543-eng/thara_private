import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class GetCitizenShipsUseCase
    extends Use_Case<Either<AppError, CitizenShipsEntity>, NoParams> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  GetCitizenShipsUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, CitizenShipsEntity>> call(NoParams params) async {
    return await _registerRepositoryImpl.getCitizenShipsDomain();
  }
}
