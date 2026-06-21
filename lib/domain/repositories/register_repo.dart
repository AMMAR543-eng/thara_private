import 'package:dartz/dartz.dart';
import '../../index/index_main.dart';

abstract class RegisterRepository {
  Future<Either<AppError, CitizenShipsEntity>> getCitizenShipsDomain();

  Future<Either<AppError, BaseEntity>> verifyOtpDomain(
    String code, {
    String? url,
  });

  Future<Either<AppError, BaseEntity>> resendOtpDomain(
      Map<String, dynamic> data,
      {String? url});

  Future<Either<AppError, LoginEntity>> registerEmailDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, BaseEntity>> addIndividualDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, SuccessNewModel>> udpatePasswordDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, BaseEntity>> addCompanyDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, NafathCodeEntity>> nafathGetCodeDomain(bool? isLogin);

  Future<Either<AppError, NafathStatusModel>> nafathCheckStatusDomain(
      bool? isLogin);

  Future<Either<AppError, KycQuestionsEntity>> getKYCQuestionsDomain();

  Future<Either<AppError, BaseEntity>> sendKYCQuestionAnswerDomain(
    Map<String, dynamic> data,
  );

  Future<Either<AppError, SuccessNewModel>>
      sendKYCQuestionAnswerWithFilesDomain(
    Map<String, dynamic> data,
    Map<String, String> files,
  );

  Future<Either<AppError, SingingDetailsEntity>> singingAgreementDomain();

  Future<Either<AppError, BaseEntity>> singingWithSirarDomain();
}
