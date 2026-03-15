import 'package:thara/Data/Models/auth/profile_model.dart';

import '../../index/index_main.dart';

abstract class AuthRemoteDataSourceRepo {
  Future<ApiResult<LoginResponseModel>> login(Map<String, dynamic> data);

  Future<ApiResult<OtpModel>> verifyOtp(String code);


  Future<ApiResult<SuccessNewModel>> biometriclogin(Map<String, dynamic> data);


  Future<ApiResult<SuccessNewModel>> uploadProfileImage(  Map<String, dynamic> data,
      Map<String, String> files,);


  Future<ApiResult<OtpModel>> resendOtp();

  Future<ApiResult<OtpModel>> me();

  Future<ApiResult<UserInfoModel>> profile_date();

  Future<ApiResult<OtpModel>> logout();

  Future<ApiResult<OtpModel>> initialResetPassword(String email, String nin);

  Future<ApiResult<OtpModel>> resetPassword(
    String email,
    String nin,
    String code,
    String password,
    String passwordConfirm,
  );
}
