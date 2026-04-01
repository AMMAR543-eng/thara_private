import 'package:thara/Presentation/screens/opportunity_details/widgets/cancel_bttomsheet.dart';
import 'package:thara/Presentation/screens/process/withdraw/cancel_bottomsheet.dart';
import '../../../index/index_main.dart';

class WithdrawListViewWidget extends StatelessWidget {
  final ProcessController controller;

  const WithdrawListViewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<WithdrawEntity> items =
        controller.withdrawDataEntity?.items ?? [];

    if (items.isEmpty) {
      return PlaceholderImage(
        image: Images.no_data,
        messege: "no_data".tr,
        isAsset: true,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final WithdrawEntity item = items[index];

        final id = item.id ?? "—";
        final String amount = item.amount ?? "0";
        final String date = item.createdAt ?? "-";
        final String? bankName = item.bankAccount?.bankName;
        final int? bankId = item.bankAccount?.bankId;
        final String iban = item.bankAccount?.iban ?? "—";

        final bool isCancelable = item.status == "waiting_for_approval" ||
            item.status == "not_verified";

        final bool is_not_verified = item.status == "not_verified";

        return _WithdrawCard(
          id: id,
          bankName: bankName ?? "bank_account".tr,
          bankId: bankId ?? 0,
          iban: iban,
          amount: amount,
          controller: controller,
          date: date,
          status: item.status ?? "-",
          is_not_verified: is_not_verified,
          transferringStatus: item.transferringStatus,
          isCancelable: isCancelable,
          onCancel: () {
            showCancelConfirmationDialog(
              context,
              onConfirm: () async {
                await ProcessService().cancelWithdraw(
                  params: CancelWithdrawParams(
                    bankAccountId: item.bankAccount?.bankId ?? 0,
                    amount: amount,
                    id: id,
                  ),
                  voidCallBack: (model) {
                    Get.back();
                    Loader.showSuccess(model.message ?? "");
                    controller.getWithdraw(); // 🔁 Refresh
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _WithdrawCard extends StatelessWidget {
  final String id;
  final String bankName;
  final int bankId;
  final String iban;
  final String amount;
  final String date;
  final String status;
  final String? transferringStatus;
  final bool isCancelable;
  final bool is_not_verified;
  final VoidCallback onCancel;
  final ProcessController controller;

  const _WithdrawCard({
    required this.id,
    required this.bankName,
    required this.bankId,
    required this.iban,
    required this.amount,
    required this.date,
    required this.is_not_verified,
    required this.status,
    required this.transferringStatus,
    required this.isCancelable,
    required this.onCancel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_natural_normal),
        boxShadow: [
          BoxShadow(
            color: AppColors.border_natural_normal.withValues(alpha: 0.15),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 🔹 Reference ID
          Text(
            "#$id",
            style: context.typography.header3xLarge.copyWith(
              color: AppColors.tertiary,
            ),
          ),
          SizedBox(height: 8.h),

          /// 🔹 Bank Name & IBAN
          InfoRowWidget(
            title: "bank_account".tr,
            value: "${'investment_account_prefix'.tr} $iban",
          ),
          SizedBox(height: 10.h),

          /// 🔹 Amount
          InfoRowWidget(
            title: "transaction_amount".tr,
            value: amount,
            showCurrencyIcon: true,
          ),
          SizedBox(height: 10.h),

          /// 🔹 Date
          InfoRowWidget(title: "transaction_date".tr, value: date),
          SizedBox(height: 10.h),

          /// 🔹 Status
          InfoStatusRowWidget(title: "request_status".tr, status: status),
          SizedBox(height: 8.h),

          transferringStatus == null
              ? const SizedBox()
              : InfoStatusRowWidget(
                  title: "money_transfer_status".tr,
                  status: getArabicTransferStatus(transferringStatus),
                ),

          if (is_not_verified)
            SizedBox(
              width: ScreenUtil().screenWidth,
              height: 50.h,
              child: PrimaryTextButton(
                appButtonSize: AppButtonSize.xxLarge,
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    elevation: 1,
                    backgroundColor: Colors.transparent,
                    builder: (context) => OtpView(
                      title: "verification".tr,
                      desc: "otp_sent_to_Email".tr,
                      withdrawId: id,
                      phone: LoginResponseModel()
                              .getTokenData()
                              ?.user
                              ?.phoneNumber ??
                          "",
                      page: OtpPages.withdraw,
                    ),
                  );
                },
                label: Text(
                  "complete_verification".tr,
                  style: context.typography.bodyLarge,
                ),
              ),
            ),
          SizedBox(height: 10.h),

          /// 🔴 Cancel Button
          if (isCancelable)
            CancelButton(
              onPressed: () {
                showCancelConfirmationDialog(
                  context,
                  onConfirm: () async {
                    await ProcessService().cancelWithdraw(
                      params: CancelWithdrawParams(
                        id: id,
                        amount: amount,
                        bankAccountId: bankId,
                      ),
                      voidCallBack: (response) {
                        Loader.showSuccess(response.message ?? '');
                        controller.getWithdraw();
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

void showCancelConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CancelConfirmationDialog(
      onConfirm: onConfirm,
      title: 'cancel_withdrawal_title'.tr,
      body: 'cancel_withdrawal_body'.tr,
      confirm_text: "cancel_withdrawal_confirm".tr,
      is_primary_btn: true,
    ),
  );
}

/// 🔹 Get Arabic name for transferring status
String getArabicTransferStatus(String? status) {
  if (status == null || status.isEmpty) return "-";

  final match = moneyTransferStatusList.firstWhere(
    (item) => item.name?.toUpperCase() == status.toUpperCase(),
    orElse: () => GenericListModel(name_ar: "-", name: "-", id: 0),
  );
  return match.name_ar ?? "-";
}

/// 🔹 Status row (with green dot)
class InfoStatusRowWidget extends StatelessWidget {
  final String title;
  final String status;

  const InfoStatusRowWidget({
    super.key,
    required this.title,
    required this.status,
  });

  Color get _color {
    switch (status) {
      case "approved":
        return AppColors.successForeground;
      case "waiting_for_approval":
        return AppColors.tag_icon_warning;
      case "rejected":
      case "canceled":
        return AppColors.errorForeground;
      default:
        return AppColors.textSecondaryParagraph;
    }
  }

  Color get _color_background {
    switch (status) {
      case "approved":
        return AppColors.successBackground;
      case "waiting_for_approval":
        return AppColors.background_warning_light;
      case "rejected":
      case "canceled":
        return AppColors.errorBackground;
      default:
        return AppColors.textSecondaryParagraph.withValues(alpha: 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.textSecondaryParagraph,
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 3.h, bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: _color_background,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 10, color: _color),
                  SizedBox(width: 6.w),
                  Text(
                    status.tr,
                    style: context.typography.bodyStrongMedium.copyWith(
                      color: _color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
