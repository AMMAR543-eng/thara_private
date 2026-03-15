import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class SendKycWithFilesUseCase
    extends Use_Case<Either<AppError, SuccessNewModel>, KycParam> {
  final RegisterRepository _registerRepositoryImpl;

  // Constructor
  SendKycWithFilesUseCase(this._registerRepositoryImpl);

  @override
  Future<Either<AppError, SuccessNewModel>> call(KycParam param) async {
    final Map<String, dynamic> jsonData = param.toJson();
    final Map<String, String> fileData = param.extractFiles();

    print("📦 KYC JSON: $jsonData");
    print("📎 KYC FILES: $fileData");

    return await _registerRepositoryImpl.sendKYCQuestionAnswerWithFilesDomain(
      jsonData,
      fileData,
    );
  }
}
