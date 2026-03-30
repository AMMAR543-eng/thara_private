import 'package:thara/index/index_main.dart';

class StatisticsController extends GetxController {
  TradeAccountEntity? tradeAccountEntity;
  InvestmentTransactionDataEntity? investmentEntity;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  /// ✅ Ensure data loads in sequence to avoid race condition
  Future<void> _initializeData() async {
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      // await getMeData();
      getTradeAccountData();
      getInvests();
      //getBankAccounts()
    }
  }

  void getTradeAccountData() {
    ProcessService().getTradeAccount(
      voidCallBack: (data) {
        tradeAccountEntity = data;
        update();
      },
    );
  }

  void getInvests() {
    OpportunitiesService().getInvestments(
      voidCallBack: (data) {
        investmentEntity = data;
        update();
      },
    );
  }

  List<InvestmentTransactionItemEntity> get investmentItems {
    return investmentEntity?.items ?? [];
  }
}

class InvestmentItemModel {
  final String title;
  final String statusLabel;
  final Color statusColor;
  final Color statusTextColor;
  final String date;

  const InvestmentItemModel({
    required this.title,
    required this.statusLabel,
    required this.statusColor,
    required this.statusTextColor,
    required this.date,
  });
}
