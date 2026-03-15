import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

abstract class AuthRepository {
  Future<Either<AppError, LoginResponseModel>> loginDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, BaseEntity>> verifyOtpDomain(String code);

  Future<Either<AppError, BaseEntity>> resendOtpDomain();

  Future<Either<AppError, BaseEntity>> meDomain();

  Future<Either<AppError, BaseEntity>> logoutDomain();

  Future<Either<AppError, BaseEntity>> initialResetPasswordDomain(
      String email,
      String nin,
      );

  Future<Either<AppError, SuccessNewModel>> uploadProfileImageDomain(
      Map<String, dynamic> data,
      Map<String, String> files,
      );


  Future<Either<AppError, BaseEntity>> resetPasswordDomain(
      String email,
      String nin,
      String code,
      String password,
      String passwordConfirm,
      );

  /// ✅ إضافة دالة تسجيل الدخول بالبصمة
  Future<Either<AppError, SuccessNewModel>> biometricLoginDomain(
    Map<String, dynamic> data,
  );


  /// ✅ New: Get full user profile (personal & company info)
  Future<Either<AppError, UserInfoModel>> profileDateDomain();
}
