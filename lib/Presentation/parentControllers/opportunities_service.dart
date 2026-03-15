import 'package:thara/Domain/UseCases/opportunities/GetAutoInvestmentDomainUseCase.dart';
import 'package:thara/Domain/UseCases/opportunities/PostAutoInvestmentDomainUseCase.dart';
import 'package:thara/Domain/UseCases/opportunities/CancelAutoInvestmentDomainUseCase.dart';

import '../../Domain/UseCases/opportunities/get_invests.dart';
import '../../index/index_main.dart';

class OpportunitiesService {
  Future<void> getOpportunities({
    OpportunityParameter? param,
    required Function(GetOpportunitiesEntity) voidCallBack,
  }) async {
    final result = await initUseCase(
          () => GetOpportunitiesUseCase(Get.find()),
    ).call(param ?? OpportunityParameter());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
  }

  Future<void> getOpportunityDetails({
    required Function(OpportunityDetailsEntity) voidCallBack,
    required String oppo_id,
  }) async {
    Loader.show();
    final result = await initUseCase(
          () => GetOpportunityDetailsUseCase(Get.find()),
    ).call(oppo_id);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> subscribeToLoan({
    required InvestSubscribeParam param,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
          () => SubscribeToLoanDomainUseCase(Get.find()),
    ).call(param);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> cancelSubscription({
    required String opportunityId,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();
    final result = await initUseCase(
          () => CancelSubscriptionDomainUseCase(Get.find()),
    ).call(opportunityId);
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
    Loader.dismiss();
  }

  Future<void> getInvestments({
    required Function(InvestmentTransactionDataEntity) voidCallBack,
    InvestmentFilterParams? param,
  }) async {
    final result = await initUseCase(
          () => GetInvestmentsUseCase(Get.find()),
    ).call(param ?? InvestmentFilterParams());
    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));
  }

  // ─────────────────────────────────────────────────────────────
  // 🔥 NEW: GET Auto-Invest Config
  // ─────────────────────────────────────────────────────────────
  Future<void> getAutoInvestment({
    required Function(InvestmentConfigResponseModel) voidCallBack,
  }) async {
    Loader.show();

    final result = await initUseCase(
          () => GetAutoInvestmentDomainUseCase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));

    Loader.dismiss();
  }

  // ─────────────────────────────────────────────────────────────
  // 🔥 NEW: POST Auto-Invest Config
  // ─────────────────────────────────────────────────────────────
  Future<void> postAutoInvestment({
    required Map<String, dynamic> payload,
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();

    final result = await initUseCase(
          () => PostAutoInvestmentDomainUseCase(Get.find()),
    ).call(PostAutoInvestmentParams(payload));

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));

    Loader.dismiss();
  }

  // ─────────────────────────────────────────────────────────────
  // 🔥 NEW: CANCEL Auto-Invest Config
  // ─────────────────────────────────────────────────────────────
  Future<void> cancelAutoInvestment({
    required Function(SuccessNewModel) voidCallBack,
  }) async {
    Loader.show();

    final result = await initUseCase(
          () => CancelAutoInvestmentDomainUseCase(Get.find()),
    ).call(NoParams());

    result.fold((l) => Loader.showError(l.messege), (r) => voidCallBack(r));

    Loader.dismiss();
  }
}
