import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class UploadProfileImageUsecase
    extends Use_Case<
        Either<AppError, SuccessNewModel>,
        UploadProfileImageParamsWrapper> {
  final AuthRepository _authRepository;

  // Constructor
  UploadProfileImageUsecase(this._authRepository);

  @override
  Future<Either<AppError, SuccessNewModel>> call(
      UploadProfileImageParamsWrapper params,
      ) async {
    return await _authRepository.uploadProfileImageDomain(
      params.data,
      params.files,
    );
  }
}

/// 📦 Wrapper for image upload parameters
class UploadProfileImageParamsWrapper {
  final Map<String, dynamic> data;
  final Map<String, String> files;

  const UploadProfileImageParamsWrapper({
    this.data = const {},
    required this.files,
  });
}
