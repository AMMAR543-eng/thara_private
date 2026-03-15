import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class ProfileDateDomainUseCase
    extends Use_Case<Either<AppError, UserInfoModel>, NoParams> {
  final AuthRepository _authRepositoryImpl;

  /// Constructor
  ProfileDateDomainUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, UserInfoModel>> call(NoParams params) async {
    return await _authRepositoryImpl.profileDateDomain();
  }
}
