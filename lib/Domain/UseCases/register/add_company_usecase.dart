import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class AddCompanyDomainUseCase
    extends Use_Case<Either<AppError, BaseEntity>, CompanyParam> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  AddCompanyDomainUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, BaseEntity>> call(CompanyParam params) async {
    return await _registerRepositoryImpl.addCompanyDomain(params.toJson());
  }
}
