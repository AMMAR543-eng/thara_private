import 'package:dartz/dartz.dart';
import 'package:thara/Domain/parameters/auth/register_param.dart';
import '../../../index/index_main.dart';

class UpdatePasswordUseCase
    extends Use_Case<Either<AppError, SuccessNewModel>, SignUpParam> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  UpdatePasswordUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(SignUpParam params) async {
    return await _registerRepositoryImpl.udpatePasswordDomain(params.toJson());
  }
}
