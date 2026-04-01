import 'package:flutter/services.dart';
import 'package:thara/Presentation/design_systems/widgets/guest/guest_user_dialog.dart';
import 'package:thara/Presentation/screens/wallet/balance_widget.dart';
import 'package:thara/Presentation/screens/wallet/bank_accounts/view/add_bank_widget.dart';
import 'package:thara/Presentation/screens/wallet/deposite/deposit_amount_bottom_sheet.dart';
import 'package:thara/Presentation/screens/wallet/my_bank_account_widget.dart';
import 'package:thara/Presentation/screens/process/deposite/deposite_controller.dart';
import '../../../index/index_main.dart';
import '../process/deposite/deposite_bottom_sheet.dart';
import 'bank_accounts/bank_create/create_bank_account_info_bottomsheet.dart';

class WalletView extends StatefulWidget {
  const WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final WalletController controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    // ✅ Detect if user is a guest
    final bool isGuest =
        LoginResponseModel().getTokenData()?.data?.accessToken == null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background_neutral_surface,
        appBar: HomeAppBar(title: "available_balance".tr),
        body: isGuest
            ? const GuestUserDialogWidget() // ✅ Show guest dialog if not logged in
            : GetBuilder<WalletController>(
                builder: (walletController) {
                  final accounts =
                      walletController.bankAccountDataEntity?.bankAccounts ??
                          [];

                  return Stack(
                    children: [
                      /// 🔹 Background pattern
                      Positioned(
                        left: -150,
                        top: 20,
                        child: Image.asset(
                          Images.home_pattern,
                          width: ScreenUtil().screenWidth,
                          height: 400.h,
                          fit: BoxFit.fill,
                          color: AppColors.focus_input_text.withValues(
                            alpha: 0.07,
                          ),
                        ),
                      ),

                      /// 🔹 Main Content
                      SafeArea(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// 🔹 Balance Summary
                              WalletBalanceCard(
                                balance: walletController
                                    .tradeAccountEntity?.available
                                    ?.toString(),
                                onDepositTap: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) =>
                                        const DepositAmountBottomSheet(),
                                  );
                                },
                                onWithdrawTap: () => walletController
                                    .openWithdrawBottomSheet(context),
                              ),

                              SizedBox(height: 5.h),

                              /// 🔹 Title
                              Align(
                                alignment:
                                    LocalStorage_language().read() == "ar"
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Text(
                                  "trusted_bank_accounts".tr,
                                  style: typography.headerXLarge.copyWith(
                                    color: AppColors.content_brand_secondary,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),

                              /// 🔹 Horizontal List of Bank Accounts
                              if (accounts.isEmpty)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.h),
                                  child: SizedBox(
                                    height: 130.h,
                                    width: ScreenUtil().screenWidth,
                                    child: AddBankAccountCardWidget(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isDismissible: true,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (_) =>
                                              const AddBankAccountBottomSheet(),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              else
                                SizedBox(
                                  height: 220.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: accounts.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index < accounts.length) {
                                        final account = accounts[index];

                                        String statusText;
                                        if (account.verified == true) {
                                          statusText = "verified".tr;
                                        } else if (account.isPrimary == false) {
                                          statusText = "under_review".tr;
                                        } else {
                                          statusText = "unknown".tr;
                                        }

                                        return BankAccountCardWidget(
                                          aliasName: account.alias ??
                                              account.label ??
                                              "—",
                                          bankName: account.bankName ?? "—",
                                          accountNumber:
                                              account.accountNumber ?? "—",
                                          iban: account.iban ?? "—",
                                          logo:
                                              "assets/icons/${account.bic ?? ""}.svg",
                                          status: statusText,
                                        );
                                      }

                                      return AddBankAccountCardWidget(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (_) =>
                                                const AddBankAccountBottomSheet(),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),

                              SizedBox(height: 20.h),

                              /// 🔹 Dynamic Bank Info from DepositeController
                              GetBuilder<DepositeController>(
                                init: DepositeController(),
                                builder: (depositController) {
                                  final userName = depositController
                                          .baseEntity?.user?.name ??
                                      "—";
                                  final iban = depositController.baseEntity
                                          ?.account?.virtualAccount?.iban ??
                                      "—";
                                  final accountNumber = depositController
                                          .baseEntity
                                          ?.account
                                          ?.virtualAccount
                                          ?.accountNumber ??
                                      "—";

                                  return DetailedBankCardWidget(
                                    bankName: "arab_bank".tr,
                                    ownerName: userName,
                                    iban: iban,
                                    accountNumber: accountNumber,
                                    logoPath: IconsConstants.anb,
                                    isPrimary: true,
                                    onCopyIban: () {
                                      Clipboard.setData(
                                        ClipboardData(text: iban),
                                      );
                                      Loader.showSuccess("iban_copied".tr);
                                    },
                                    onCopyAccount: () {
                                      Clipboard.setData(
                                        ClipboardData(text: accountNumber),
                                      );
                                      Loader.showSuccess("account_copied".tr);
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
