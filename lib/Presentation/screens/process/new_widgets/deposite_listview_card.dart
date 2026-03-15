import '../../../../index/index_main.dart';

class DepositCard extends StatelessWidget {
  final String ref;
  final String accountLabel;
  final String sourceIban;
  final String formattedAmount;
  final String date;

  const DepositCard({
    required this.ref,
    required this.accountLabel,
    required this.sourceIban,
    required this.formattedAmount,
    required this.date,
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
        children: [
          /// 🔹 Request Reference
          Text(
            "#$ref",
            style: context.typography.header3xLarge.copyWith(
              color: AppColors.tertiary,
            ),
          ),
          SizedBox(height: 8.h),

          /// 🔹 Source IBAN
          InfoRowWidget(
            title: "transfer_source".tr,
            value: "$accountLabel - $sourceIban",
          ),
          SizedBox(height: 10.h),

          /// 🔹 Amount
          InfoRowWidget(
            title: "transaction_amount".tr,
            value: formattedAmount,
            showCurrencyIcon: true,
          ),
          SizedBox(height: 10.h),

          /// 🔹 Date
          InfoRowWidget(
            title: "transaction_date".tr,
            value: date,
          ),
          SizedBox(height: 10.h),

          /// 🔹 Status
          StatusRowWidget(statusText: "active_status".tr),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
