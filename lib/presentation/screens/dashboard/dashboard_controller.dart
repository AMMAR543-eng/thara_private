import 'package:flutter/foundation.dart';
import '../../../index/index_main.dart';

class DashboardController extends GetxController {
  /// 🔹 Data Models
  GetOpportunitiesEntity? availableOpportunities;
  GetOpportunitiesEntity? upcomingOpportunities;
  TradeAccountEntity? tradeAccountEntity;
  BankAccountDataEntity? bankAccountDataEntity;
  InvestmentTransactionDataEntity? investmentEntity;
  ProfitSummaryDataModel? monthlyProfitData;
  InvestmentConfigResponseModel? investmentConfigResponseModel;

  /// 🔹 States
  bool isProfessional = false;
  bool isWaitingProfessional = false;

  bool isLoading = true;
  bool isInvestLoading = false;
  bool isBankLoading = false;
  bool isTradeLoading = false;
  bool isProfitLoading = false;
  bool isAvailableLoading = false;
  bool isUpcomingLoading = false;

  /// 🔴 Error States
  String? globalError;
  String? availableError;
  String? upcomingError;
  String? investError;
  String? tradeError;
  String? bankError;
  String? profitError;

  final OpportunitiesService _service = OpportunitiesService();

  /// 🔹 Filters
  GenericListModel? selectedStatusFilter;
  String? startDateFilter;
  String? endDateFilter;
  String? searchTextFilter;

  // ================================
  // 🔥 GLOBAL ERROR HANDLER
  // ================================
  void _handleError(Object e, {String? message}) {
    final msg = message ?? "Something went wrong";

    if (kDebugMode) {
      print(" ERROR: $e");
    }

    Get.snackbar(
      "Error",
      msg,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ================================
  // 🧹 Filters
  // ================================
  void clearStatusFilter() {
    selectedStatusFilter = null;
    getInvests();
  }

  void clearDateFilter() {
    startDateFilter = null;
    endDateFilter = null;
    getInvests();
  }

  void clearSearchFilter() {
    searchTextFilter = null;
    getInvests();
  }

  // ================================
  // 🔹 INIT
  // ================================
  @override
  void onInit() {
    super.onInit();
    _initDashboardParallel();
  }

  Future<void> _initDashboardParallel() async {
    try {
      isLoading = true;
      globalError = null;
      update();

      final token = LoginResponseModel().getTokenData()?.data?.accessToken;

      if (token != null) {
        await Future.wait([
          _loadBackgroundData(),
          getAutoInvestDataFuture(), // 👈 نحولها future
        ]);
      }

      await Future.wait([
        getAvailableOpportunities(),
        getUpcomingOpportunities(),
      ]);
    } catch (e) {
      globalError = "Failed to load dashboard";
      _handleError(e, message: globalError);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> _loadBackgroundData() async {
    await Future.wait([
      getTradeAccountData(),
      getBankAccounts(),
      getInvests(),
      getMonthlyData(),
      getMeData(),
    ]);
  }

  // ================================
  // 🔹 AUTO INVEST
  // ================================
  Future<void> getAutoInvestDataFuture() async {
    final completer = Completer<void>();

    _service.getAutoInvestment(
      voidCallBack: (data) {
        investmentConfigResponseModel = data;
        update();
        completer.complete();
      },
    );

    return completer.future;
  }

  // ================================
  // 🔹 AVAILABLE
  // ================================
  Future<void> getAvailableOpportunities() async {
    try {
      isAvailableLoading = true;
      availableError = null;
      update();

      final completer = Completer<GetOpportunitiesEntity>();

      OpportunitiesService().getOpportunities(
        param: OpportunityParameter(
          page: 1,
          status: subscription_status.available,
        ),
        voidCallBack: completer.complete,
      );

      availableOpportunities = await completer.future;
    } catch (e) {
      availableError = "Failed to load opportunities";
      _handleError(e, message: availableError);
    } finally {
      isAvailableLoading = false;
      update();
    }
  }

  // ================================
  // 🔹 UPCOMING
  // ================================
  Future<void> getUpcomingOpportunities() async {
    try {
      isUpcomingLoading = true;
      upcomingError = null;
      update();

      final completer = Completer<GetOpportunitiesEntity>();

      OpportunitiesService().getOpportunities(
        param: OpportunityParameter(
          page: 1,
          status: subscription_status.upcoming,
        ),
        voidCallBack: completer.complete,
      );

      upcomingOpportunities = await completer.future;
    } catch (e) {
      upcomingError = "Failed to load upcoming opportunities";
      _handleError(e, message: upcomingError);
    } finally {
      isUpcomingLoading = false;
      update();
    }
  }

  // ================================
  // 🔹 INVESTMENTS
  // ================================
  Future<void> getInvests() async {
    try {
      isInvestLoading = true;
      investError = null;
      update();

      final params = InvestmentFilterParams(
        page: 1,
        fromDate: startDateFilter,
        endDate: endDateFilter,
        status: selectedStatusFilter?.text ?? selectedStatusFilter?.name,
        query: searchTextFilter,
      );

      final completer = Completer<InvestmentTransactionDataEntity>();

      OpportunitiesService().getInvestments(
        param: params,
        voidCallBack: completer.complete,
      );

      investmentEntity = await completer.future;
    } catch (e) {
      investError = "Failed to load investments";
      _handleError(e, message: investError);
    } finally {
      isInvestLoading = false;
      update();
    }
  }

  List<InvestmentTransactionItemEntity> get investmentItems =>
      investmentEntity?.items ?? [];

  // ================================
  // 🔹 TRADE
  // ================================
  Future<void> getTradeAccountData() async {
    try {
      isTradeLoading = true;
      tradeError = null;
      update();

      final completer = Completer<TradeAccountEntity>();

      ProcessService().getTradeAccount(voidCallBack: completer.complete);

      tradeAccountEntity = await completer.future;
    } catch (e) {
      tradeError = "Failed to load trade account";
      _handleError(e, message: tradeError);
    } finally {
      isTradeLoading = false;
      update();
    }
  }

  // ================================
  // 🔹 PROFIT
  // ================================
  Future<void> getMonthlyData({String? year}) async {
    try {
      isProfitLoading = true;
      profitError = null;
      update();

      final selectedYear = year ?? DateTime.now().year.toString();

      final completer = Completer<ProfitSummaryDataModel>();

      ProcessService().getMonthlyProfit(
        year: selectedYear,
        voidCallBack: completer.complete,
      );

      monthlyProfitData = await completer.future;
    } catch (e) {
      profitError = "Failed to load profit data";
      _handleError(e, message: profitError);
    } finally {
      isProfitLoading = false;
      update();
    }
  }

  // ================================
  // 🔹 USER DATA
  // ================================
  Future<void> getMeData() async {
    try {
      final completer = Completer<BaseEntity>();

      AuthService().me(voidCallBack: completer.complete);

      final data = await completer.future;

      isProfessional = data.account?.isProfessionalInvestor ?? false;
      isWaitingProfessional = data.account?.thereIsWaitingRequest ?? false;
    } catch (e) {
      _handleError(e, message: "Failed to load user data");
    } finally {
      update();
    }
  }

  // ================================
  // 🔹 BANK
  // ================================
  Future<void> getBankAccounts() async {
    try {
      isBankLoading = true;
      bankError = null;
      update();

      final completer = Completer<BankAccountDataEntity>();

      ProcessService().getBankAccounts(
        processParam: ProcessFilterParams(),
        voidCallBack: completer.complete,
      );

      bankAccountDataEntity = await completer.future;
    } catch (e) {
      bankError = "Failed to load bank accounts";
      _handleError(e, message: bankError);
    } finally {
      isBankLoading = false;
      update();
    }
  }

  InvestmentWizardEntity mapConfigToWizardEntity(InvestmentConfigModel config) {
    return InvestmentWizardEntity(
      amount: InvestmentAmount(
        min: config.minInvestAmount?.toString(),
        max: config.maxInvestAmount?.toString(),
      ),
      opportunities: config.opportunityTypes
          ?.map(
            (key) => OpportunityType(
              id: key.hashCode,
              name: getOpportunityName(key),
              apiKey: key,
              selected: true,
            ),
          )
          .toList(),
      packages: config.creditRatings
          ?.map(
            (p) => PackageEntity(
              id: p.hashCode,
              title: p,
              description: "",
              selected: true,
            ),
          )
          .toList(),
      durations: config.durations
          ?.map(
            (d) => InvestmentDuration(
              id: d.hashCode,
              title: getDurationLabel(d),
              apiValue: d,
              selected: true,
            ),
          )
          .toList(),
    );
  }

  String getOpportunityName(String apiKey) {
    switch (apiKey) {
      case "invoice":
        return "opportunity_invoice".tr;
      case "real_state":
        return "opportunity_real_state".tr;
      default:
        return apiKey;
    }
  }

  String getDurationLabel(String apiVal) {
    switch (apiVal) {
      case "6":
        return "duration_6_months".tr;
      case "12":
        return "duration_12_months".tr;
      case "18":
        return "duration_18_plus_months".tr;
      default:
        return apiVal;
    }
  }
}
