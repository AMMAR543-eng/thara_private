import 'package:thara/Presentation/screens/process/deposite/deposite_bottom_sheet.dart';
import 'package:thara/Presentation/screens/process/withdraw/withdraw_bottom_sheet.dart';
import '../../../index/index_main.dart';

class ProcessController extends GetxController {
  TradeAccountEntity? tradeAccountEntity;
  DepositeDataEntity? depositeDataEntity;
  WithdrawDataEntity? withdrawDataEntity;
  BankAccountDataEntity? bankAccountDataEntity;
  List<GenericListModel>? list_accounts;

  // 🔹 Filters state for Withdraw / Deposit operations
  GenericListModel? selectedStatusFilter;
  GenericListModel? selectedMoneyTransferStatusFilter;

  String? startDateFilter;
  String? endDateFilter;
  String? searchTextFilter;

  ProcessFilterParams depositeFilterParams = ProcessFilterParams(page: 1);
  ProcessFilterParams withdrawFilterParams = ProcessFilterParams(page: 1);

  bool isProfessional = false;
  bool isWaitingProfessional = false;
  bool isBalanceVisible = false;
  var tab_index = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeData();

  }

  /// ✅ Ensure data loads in sequence to avoid race condition
  Future<void> _initializeData() async {
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      // await getMeData();
      await getTradeData(); // must load before deposits/withdraws
      await Future.wait([getDeposite(), getWithdraw()]);
      //getBankAccounts()
    }
  }

  void toggleBalanceVisibility() {
    isBalanceVisible = !isBalanceVisible;
    update();
  }

  void tabsActions(int index) {
    tab_index = index;

    // 🔸 Clear all filters when switching tabs
    selectedStatusFilter = null;
    selectedMoneyTransferStatusFilter = null;
    startDateFilter = null;
    endDateFilter = null;
    searchTextFilter = null;
    // 🔸 Refresh corresponding data
    if (index == 0) {
      depositeFilterParams = ProcessFilterParams(page: 1);
      getDeposite();
    } else if (index == 1) {
      withdrawFilterParams = ProcessFilterParams(page: 1);
      getWithdraw();
    } else {
      getBankAccounts();
    }

    update();
  }

  Future<void> getMeData() async {
    final completer = Completer<void>();
    AuthService().me(
      voidCallBack: (data) {
        isProfessional = data.account?.isProfessionalInvestor ?? false;
        isWaitingProfessional = data.account?.thereIsWaitingRequest ?? false;
        update();
        completer.complete();
      },
    );
    return completer.future;
  }

  Future<void> getTradeData() async {
    final completer = Completer<void>();
    ProcessService().getTradeAccount(
      voidCallBack: (data) {
        tradeAccountEntity = data;
        update();
        completer.complete();
      },
    );
    return completer.future;
  }

  Future<void> getDeposite() async {
    final completer = Completer<void>();
    if (tradeAccountEntity == null) {
      completer.complete();
      return completer.future; // don't call if trade account not loaded
    }
    ProcessService().getDeposite(
      processParam: depositeFilterParams,
      voidCallBack: (data) {
        depositeDataEntity = data;
        update();
        completer.complete();
      },
    );
    return completer.future;
  }

  Future<void> getWithdraw() async {
    final completer = Completer<void>();
    if (tradeAccountEntity == null) {
      completer.complete();
      return completer.future;
    }
    ProcessService().getWithdraws(
      processParam: withdrawFilterParams,
      voidCallBack: (data) {
        withdrawDataEntity = data;
        update();
        completer.complete();
      },
    );
    return completer.future;
  }

  Future<void> getBankAccounts() async {
    final completer = Completer<void>();
    ProcessService().getBankAccounts(
      processParam: ProcessFilterParams(),
      voidCallBack: (data) {
        bankAccountDataEntity = data;
        update();
        completer.complete();
      },
    );
    return completer.future;
  }

  openDepositeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      elevation: 1,
      backgroundColor: Colors.transparent,
      builder: (context) => const DepositMethodBottomSheet(),
    );
  }

  openWithdrawBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      elevation: 1,
      backgroundColor: Colors.transparent,
      builder: (context) => WithdrawBottomSheet(
        bankAccounts:
            bankAccountDataEntity?.bankAccounts
                ?.map(
                  (e) => GenericListModel(
                    id: e.id ?? 0,
                    name: e.bankName ?? '',
                    text: e.accountNumber ?? '',
                  ),
                )
                .toList() ??
            [],
      ),
    );
  }

  Future<void> showFilterBottomSheet(BuildContext context) async {
    if (tab_index == 0) {
      TransactionFilterBottomSheet.open(
        context,
        controller: this,
        isFromDeposite: true,
      );

      // if (result is ProcessFilterParams) {
      //   depositeFilterParams = result;
      //   await getDeposite();
      // }
    } else if (tab_index == 1) {
      TransactionFilterBottomSheet.open(
        context,
        controller: this,
        isFromDeposite: false,
      );

      // if (result is ProcessFilterParams) {
      //   withdrawFilterParams = result;
      //   await getWithdraw();
      // }
    }
  }


}
