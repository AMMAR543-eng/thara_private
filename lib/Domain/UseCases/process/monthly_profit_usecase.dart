import 'package:dartz/dartz.dart';
import '../../../index/index_main.dart';

class MonthlyProfitUseCase
    extends Use_Case<Either<AppError, ProfitSummaryDataModel>, String> {
  final ProcessRepository _processRepositoryImpl;

  // Constructor
  MonthlyProfitUseCase(this._processRepositoryImpl);

  @override
  Future<Either<AppError, ProfitSummaryDataModel>> call(String year) async {
    // Fetch monthly profit data from the repository
    return await _processRepositoryImpl.monthlyProfitDomain(
      {},
      year, // Assuming your ProcessFilterParams has a 'year' field
    );
  }
}
