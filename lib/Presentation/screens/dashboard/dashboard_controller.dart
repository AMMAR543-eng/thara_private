import 'dart:async';
import 'package:thara/Domain/UseCases/opportunities/get_invests.dart';
import 'package:thara/Presentation/screens/dashboard/pagination_opportunity.dart';
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
  final OpportunitiesService _service = OpportunitiesService();

  /// 🔹 Filters
  GenericListModel? selectedStatusFilter;
  String? startDateFilter;
  String? endDateFilter;
  String? searchTextFilter;

  // ─────────────────────────────
  // 🧹 Clear Filters
  // ─────────────────────────────
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
        return "فواتير";
      case "real_state":
        return "تطوير عقاري";
      default:
        return apiKey;
    }
  }

  String getDurationLabel(String apiVal) {
    switch (apiVal) {
      case "6":
        return "حتى 6 أشهر";
      case "12":
        return "12 شهرًا";
      case "18":
        return "أكثر من 12 شهرًا";
      default:
        return apiVal;
    }
  }

  // ─────────────────────────────
  // 🔹 Init Dashboard
  // ─────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _initDashboardParallel();
  }

  getAutoInvestData() {
    _service.getAutoInvestment(
      voidCallBack: (data) {
        investmentConfigResponseModel = data;

        update();
      },
    );
  }

  /// ✅ Run APIs in parallel — non-blocking and efficient
  Future<void> _initDashboardParallel() async {
    try {
      isLoading = true;
      update();
      // Then run background data calls

      final token = LoginResponseModel().getTokenData()?.data?.accessToken;
      if (token != null) {
        unawaited(_loadBackgroundData());
        getAutoInvestData();
      }

      // Fetch both opportunity types first (so the UI shows content fast)
      await Future.wait([
        getAvailableOpportunities(),
        getUpcomingOpportunities(),
      ]);
    } catch (e, s) {
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Run background tasks concurrently
  Future<void> _loadBackgroundData() async {
    await Future.wait([
      getTradeAccountData(),
      getBankAccounts(),
      getInvests(),
      getMonthlyData(),
      getMeData(),
      getMeData(),
    ]);
  }

  // ─────────────────────────────
  // 🔹 Available Opportunities
  // ─────────────────────────────
  Future<void> getAvailableOpportunities() async {
    try {
      isAvailableLoading = true;
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
    } finally {
      isAvailableLoading = false;
      update();
    }
  }

  // ─────────────────────────────
  // 🔹 Upcoming Opportunities
  // ─────────────────────────────
  Future<void> getUpcomingOpportunities() async {
    try {
      isUpcomingLoading = true;
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
    } finally {
      isUpcomingLoading = false;
      update();
    }
  }

  // ─────────────────────────────
  // 🔹 Investments
  // ─────────────────────────────
  Future<void> getInvests() async {
    try {
      isInvestLoading = true;
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
    } finally {
      isInvestLoading = false;
      update();
    }
  }

  List<InvestmentTransactionItemEntity> get investmentItems =>
      investmentEntity?.items ?? [];

  // ─────────────────────────────
  // 🔹 Trade Account
  // ─────────────────────────────
  Future<void> getTradeAccountData() async {
    try {
      isTradeLoading = true;
      final completer = Completer<TradeAccountEntity>();
      ProcessService().getTradeAccount(voidCallBack: completer.complete);
      tradeAccountEntity = await completer.future;
    } catch (e) {
    } finally {
      isTradeLoading = false;
      update();
    }
  }

  // ─────────────────────────────
  // 🔹 Monthly Profit
  // ─────────────────────────────
  Future<void> getMonthlyData({String? year}) async {
    try {
      isProfitLoading = true;
      final selectedYear = year ?? DateTime.now().year.toString();

      final completer = Completer<ProfitSummaryDataModel>();
      ProcessService().getMonthlyProfit(
        year: selectedYear,
        voidCallBack: completer.complete,
      );
      monthlyProfitData = await completer.future;
    } catch (e) {
    } finally {
      isProfitLoading = false;
      update();
    }
  }

  // ─────────────────────────────
  // 🔹 User Info
  // ─────────────────────────────
  Future<void> getMeData() async {
    try {
      final completer = Completer<BaseEntity>();
      AuthService().me(voidCallBack: completer.complete);
      final result = await completer.future;
      final data = result;

      isProfessional = data.account?.isProfessionalInvestor ?? false;
      isWaitingProfessional = data.account?.thereIsWaitingRequest ?? false;
    } catch (e) {
    } finally {
      update();
    }
  }

  // ─────────────────────────────
  // 🔹 Bank Accounts
  // ─────────────────────────────
  Future<void> getBankAccounts() async {
    try {
      isBankLoading = true;
      final completer = Completer<BankAccountDataEntity>();
      ProcessService().getBankAccounts(
        processParam: ProcessFilterParams(),
        voidCallBack: completer.complete,
      );
      bankAccountDataEntity = await completer.future;
    } catch (e) {
    } finally {
      isBankLoading = false;
      update();
    }
  }
}
