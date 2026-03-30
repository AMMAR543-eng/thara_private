import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  late final RegisterRemoteDataSourceRepo _registerRemoteDataSourceRepo;

  RegisterRepositoryImpl(this._registerRemoteDataSourceRepo);

  @override
  Future<Either<AppError, CitizenShipsEntity>> getCitizenShipsDomain() async {
    final result = await _registerRemoteDataSourceRepo.getCitizenShips();

    return result is Success<CitizenResponseModel>
        ? right(result.data.data ?? const CitizenShipsEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> verifyOtpDomain(
    String code, {
    String? url,
  }) async {
    final result = await _registerRemoteDataSourceRepo.verifyOtp(
      code,
      url: url,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> resendOtpDomain(
    Map<String, dynamic> data, {
    String? url,
  }) async {
    final result = await _registerRemoteDataSourceRepo.resendOtp(
      data,
      url: url,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, LoginEntity>> registerEmailDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _registerRemoteDataSourceRepo.registerEmail(data);

    return result is Success<LoginResponseModel>
        ? right(result.data.data ?? const LoginEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> addIndividualDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _registerRemoteDataSourceRepo.addIndividual(data);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> addCompanyDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _registerRemoteDataSourceRepo.addCompany(data);

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, NafathCodeEntity>> nafathGetCodeDomain(bool? isLogin) async {
    final result = await _registerRemoteDataSourceRepo.nafathGetCode(isLogin);

    return result is Success<NafathGetCodeModel>
        ? right(result.data.data ?? const NafathCodeEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, NafathStatusModel>> nafathCheckStatusDomain(bool? isLogin) async {
    final result = await _registerRemoteDataSourceRepo.nafathCheckStatus(isLogin);

    return result is Success<NafathStatusModel>
        ? right(result.data)
        : left(
            AppError(
              (result as Failure).errorHandler.message ?? "",
              account: (result as Failure).errorHandler.account,
            ),
          );
  }

  @override
  Future<Either<AppError, KycQuestionsEntity>> getKYCQuestionsDomain() async {
    final result = await _registerRemoteDataSourceRepo.getKYCQuestions();

    return result is Success<KYCResponseModel>
        ? right(result.data.data ?? const KycQuestionsEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> sendKYCQuestionAnswerDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _registerRemoteDataSourceRepo.sendKYCQuestionAnswer(
      data,
    );

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SingingDetailsEntity>>
  singingAgreementDomain() async {
    final result = await _registerRemoteDataSourceRepo
        .singingAgreementDetails();

    return result is Success<SingingAgreementModel>
        ? right(result.data.data ?? const SingingDetailsEntity())
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, BaseEntity>> singingWithSirarDomain() async {
    final result = await _registerRemoteDataSourceRepo.singingWithSirar();

    return result is Success<OtpModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> udpatePasswordDomain(
    Map<String, dynamic> data,
  ) async {
    final result = await _registerRemoteDataSourceRepo.udpate_Password(data);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }

  @override
  Future<Either<AppError, SuccessNewModel>> sendKYCQuestionAnswerWithFilesDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  ) async {
    final result = await _registerRemoteDataSourceRepo.sendKYCQuestionAnswerWithFiles(data,files);

    return result is Success<SuccessNewModel>
        ? right(result.data)
        : left(AppError((result as Failure).errorHandler.message ?? ""));
  }
}
