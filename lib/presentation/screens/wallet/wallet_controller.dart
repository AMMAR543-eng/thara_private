import 'package:thara/Presentation/screens/process/withdraw/withdraw_bottom_sheet.dart';
import 'package:thara/index/index_main.dart';

class WalletController extends GetxController {
  TradeAccountEntity? tradeAccountEntity;
  BankAccountDataEntity? bankAccountDataEntity;

  @override
  void onInit() {
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      getTradeAccountData();
      getBankAccounts();
    }

    super.onInit();
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

  void getTradeAccountData() {
    ProcessService().getTradeAccount(
      voidCallBack: (data) {
        tradeAccountEntity = data;
        update();
      },
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
        bankAccounts: bankAccountDataEntity?.bankAccounts
                ?.map(
                  (e) => GenericListModel(
                    id: e.id ?? 0,
                    name: e.bankName ?? '',
                    text: "${e.bankName ?? ''} - ${e.accountNumber ?? ''} ",
                  ),
                )
                .toList() ??
            [],
      ),
    );
  }

  // ============================
  // 💳 WALLET PAYMENT
  // ============================

  Future<CreatePaymentResponseModel?> createWalletPayment({
    required WalletPaymentParams params,
  }) async {
    final completer = Completer<CreatePaymentResponseModel?>();

    ProcessService().createWalletPayment(
      params: params,
      voidCallBack: (response) {
        completer.complete(response);
      },
    );

    return completer.future;
  }

  Future<CheckPaymentResponseModel?> checkWalletPayment({
    required String paymentId,
  }) async {
    final completer = Completer<CheckPaymentResponseModel?>();

    ProcessService().checkWalletPayment(
      paymentId: paymentId,
      voidCallBack: (response) {
        completer.complete(response);
        update();
      },
    );

    return completer.future;
  }
}
