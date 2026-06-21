import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

class AuthRepositoryImpl extends AuthRepository {
  late final AuthRemoteDataSourceRepo _authRemoteDataSourceRepo;

  AuthRepositoryImpl(this._authRemoteDataSourceRepo);

  @override
  Future<Either<AppError, LoginResponseModel>> loginDomain(
      Map<String, dynamic> data) async {
    final result = await _authRemoteDataSourceRepo.login(data);

    return result is Success<LoginResponseModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> verifyOtpDomain(String code) async {
    final result = await _authRemoteDataSourceRepo.verifyOtp(code);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> resendOtpDomain() async {
    final result = await _authRemoteDataSourceRepo.resendOtp();

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> meDomain() async {
    final result = await _authRemoteDataSourceRepo.me();

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> logoutDomain() async {
    final result = await _authRemoteDataSourceRepo.logout();

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> initialResetPasswordDomain(
    String email,
    String nin,
  ) async {
    final result =
        await _authRemoteDataSourceRepo.initialResetPassword(email, nin);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> resetPasswordDomain(
    String email,
    String nin,
    String code,
    String password,
    String passwordConfirm,
  ) async {
    final result = await _authRemoteDataSourceRepo.resetPassword(
      email,
      nin,
      code,
      password,
      passwordConfirm,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  /// ✅ إضافة دالة تسجيل الدخول بالبصمة
  @override
  Future<Either<AppError, SuccessNewModel>> biometricLoginDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _authRemoteDataSourceRepo.biometriclogin(data);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, UserInfoModel>> profileDateDomain() async {
    final result = await _authRemoteDataSourceRepo.profile_date();

    return result is Success<UserInfoModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  // ---------------------------------------------------------------------------
  // 🆕 Upload Profile Image
  // ---------------------------------------------------------------------------

  @override
  Future<Either<AppError, SuccessNewModel>> uploadProfileImageDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    final result =
        await _authRemoteDataSourceRepo.uploadProfileImage(data, files);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }
}
