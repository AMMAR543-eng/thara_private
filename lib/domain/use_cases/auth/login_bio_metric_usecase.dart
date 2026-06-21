import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

/// Use case for performing biometric login
class BiometricLoginUseCase
    extends Use_Case<Either<AppError, SuccessNewModel>, BiometricLoginParams> {
  final AuthRepository _authRepositoryImpl;

  BiometricLoginUseCase(this._authRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
    BiometricLoginParams params,
  ) async {
    return await _authRepositoryImpl.biometricLoginDomain(params.toMap());
  }
}

/// Parameter class for biometric login use case
class BiometricLoginParams {
  final String token;
  final String uuid;

  const BiometricLoginParams({
    required this.token,
    required this.uuid,
  });

  /// Converts the params to a Map for repository layer
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'uuid': uuid,
    };
  }
}
