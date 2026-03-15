
import '../../index/index_main.dart';

abstract class OpportunitiesRemoteDataSourceRepo {
  Future<ApiResult<OpportunitiesResponse>> getOpportunities(Map<String, dynamic> data);

  Future<ApiResult<InvestmentTransactionDataModel>> getInvestments(Map<String, dynamic> data);

  Future<ApiResult<OpportunityDetailsModel>> getOpportunityDetails(
      String opportunityId,
      );

  Future<ApiResult<SuccessNewModel>> subscribeToLoan(
      String opportunityId,
      int volume,
      );

  Future<ApiResult<SuccessNewModel>> cancelSubscription(String opportunityId);

  /// 🔥 NEW: Get Auto-Investment Configuration
  Future<ApiResult<InvestmentConfigResponseModel>> getAutoInvestment();

  /// 🔥 NEW: Save / Update Auto-Investment Configuration
  Future<ApiResult<SuccessNewModel>> postAutoInvestment(Map<String, dynamic> payload);


  Future<ApiResult<SuccessNewModel>> cancelAutoInvestment();

}
