
import '../../index/index_main.dart';

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
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<OpportunityDetailsModel>> getOpportunityDetails(
      String opportunityId,
      ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.opportunityById(opportunityId), // ✅ FIX
      );

      final model = OpportunityDetailsModel.fromJson(response);
      return Success(model);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
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
        ApiConstatns.subscribe(opportunityId), // ✅ FIX
        params: {"volume": volume},
      );

      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> cancelSubscription(
      String opportunityId,
      ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.PATCH,
        ApiConstatns.cancelSubscription(opportunityId), // ✅ FIX
      );

      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<InvestmentTransactionDataModel>> getInvestments(
      Map<String, dynamic> data,
      ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.invests, // ✅ already ok
        params: data,
      );

      final model =
      InvestmentTransactionsResponseModel.fromJson(response);

      return Success(
        model.data ?? const InvestmentTransactionDataModel(),
      );
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  // ─────────────────────────────────────────────
  // 🔥 AUTO INVESTMENT
  // ─────────────────────────────────────────────

  @override
  Future<ApiResult<InvestmentConfigResponseModel>> getAutoInvestment() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.GET,
        ApiConstatns.autoInvestmentConfig,
      );

      final model = InvestmentConfigResponseModel.fromJson(response);
      return Success(model);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> postAutoInvestment(
      Map<String, dynamic> payload,
      ) async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.POST,
        ApiConstatns.autoInvestmentConfig,
        params: payload,
      );

      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<SuccessNewModel>> cancelAutoInvestment() async {
    try {
      final response = await _clientSoureceRepo.request(
        HttpMethod.PATCH,
        ApiConstatns.autoInvestmentConfigDelete,
        params: {"active": false},
      );

      final model = SuccessNewModel.fromJson(response);
      return Success(model);
    } catch (error) {
      return Failure(ErrorHandler.handle(error));
    }
  }
}