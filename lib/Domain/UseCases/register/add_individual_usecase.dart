import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class AddIndividualDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, IndividualParam> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  AddIndividualDomainUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(IndividualParam params) async {
    return await _registerRepositoryImpl.addIndividualDomain(params.toJson());
  }
}
