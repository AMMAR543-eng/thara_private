import '../../index/index_main.dart';
import '../Models/investements/inv_data_model.dart';

class OpportunitiesRemoteDataSourceImpl
    extends OpportunitiesRemoteDataSourceRepo {
  late final ClientSourceRepo _clientSoureceRepo;

  OpportunitiesRemoteDataSourceImpl(ClientSourceRepo client) {
    _clientSoureceRepo = client;
  }

  @override
  Future<ApiResult<OpportunitiesResponse>> getOpportunities(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.opportunitiesUrl,
        params: data,
      );
      final opportunitiesItems = OpportunitiesResponse.fromJson(response);
      return Success(opportunitiesItems);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<OpportunityDetailsModel>> getOpportunityDetails(
    String opportunityId,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        "${ApiConstatns.opportunityIdUrl}$opportunityId",
      );
      final opportunityDetailsItem = OpportunityDetailsModel.fromJson(response);
      return Success(opportunityDetailsItem);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> subscribeToLoan(
    String opportunityId,
    int volume,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        "${ApiConstatns.opportunityIdUrl}$opportunityId/subscribe",
        params: {"volume": volume},
      );
      final opportunitiesItems = SuccessNewModel.fromJson(response);
      return Success(opportunitiesItems);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> cancelSubscription(
    String opportunityId,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.PATCH,
        "${ApiConstatns.opportunityIdUrl}$opportunityId/cancel_subscription",
      );
      final opportunitiesItems = SuccessNewModel.fromJson(response);
      return Success(opportunitiesItems);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<InvestmentTransactionDataModel>> getInvestments(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.invests,
        params: data,
      );
      final opportunitiesItems = InvestmentTransactionsResponseModel.fromJson(
        response,
      );

      return Success(
        opportunitiesItems.data ?? const InvestmentTransactionDataModel(),
      );
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  // ─────────────────────────────────────────────────────────────
  // 🔥 NEW METHODS
  // ─────────────────────────────────────────────────────────────

  @override
  Future<ApiResult<InvestmentConfigResponseModel>> getAutoInvestment() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.autoInvestmentConfig, // ← endpoint path
      );

      final model = InvestmentConfigResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> postAutoInvestment(
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.autoInvestmentConfig, // ← same endpoint for POST
        params: payload,
        auto_invest: true,
      );

      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> cancelAutoInvestment() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.PATCH,
        params: {"active": false},
        ApiConstatns.autoInvestmentConfigDelete, // ← same endpoint for POST
      );

      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      final handledError = ErrorHandler.handle(error);
      return Failure(handledError);
    }
  }
}
