import 'package:intl/intl.dart';

import '../../../../index/index_main.dart';

import '../../../../index/index_main.dart';

class PaymentScheduleWidget extends StatelessWidget {
  final OpportunitiesItemsEntity? opportunity;

  const PaymentScheduleWidget({super.key, required this.opportunity});

  @override
  Widget build(BuildContext context) {
    final schedules = opportunity?.paymentsSchedule ?? [];

    if (schedules.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Text(
            "payment_schedule".tr,
            style: context.typography.headerXLarge.copyWith(
              color: AppColors.content_brand_secondary,
            ),
          ),
        ),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final item = schedules[index];
              final paymentTitle =
                  "${'payment_number'.tr} ${_localizedOrdinal(index + 1)}";

              final dueDate = item.dueToDate ?? "notYet".tr;

              /// Convert to double
              final interest = double.tryParse(item.interest ?? "0") ?? 0;
              final principal = double.tryParse(item.principle ?? "0") ?? 0;
              final total = double.tryParse(item.total ?? "0") ?? 0;

              /// TAX percentage
              final taxString =
                  opportunity?.feesAndTaxPercentage?.toString() ?? "0";
              final taxPercent = double.tryParse(taxString) ?? 0;

              /// TAX calculations
              final taxValue = interest * (taxPercent / 100);
              final netProfitCalc = interest - taxValue;

              /// FORMAT ALL NUMBERS
              final interestFormatted = formatNumber(interest);
              final taxFormatted = formatNumber(taxValue);
              final principalFormatted = formatNumber(principal);
              final totalFormatted = formatNumber(total);
              final netProfitFormatted = formatNumber(netProfitCalc);

              return Container(
                width: 320.w,
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color:
                        AppColors.border_natural_normal.withValues(alpha: 0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentTitle,
                      style: context.typography.bodyStrongLarge.copyWith(
                        color: AppColors.tertiary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// RIGHT COLUMN
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _RowItem(
                                  label: "due_date".tr,
                                  value: dueDate,
                                ),
                                SizedBox(height: 10.h),
                                _RowItem(
                                  label: "interest".tr,
                                  value: interestFormatted,
                                  showRiyal: true,
                                ),
                                SizedBox(height: 10.h),
                                _RowItem(
                                  label: "taxes_and_fees".tr,
                                  value: taxFormatted,
                                  showRiyal: true,
                                ),
                              ],
                            ),
                          ),

                          /// LEFT COLUMN
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _RowItem(
                                  label: "principal_amount".tr,
                                  value: principalFormatted,
                                  showRiyal: true,
                                ),
                                SizedBox(height: 10.h),
                                _RowItem(
                                  label: "total_payment".tr,
                                  value: totalFormatted,
                                  showRiyal: true,
                                ),
                                SizedBox(height: 10.h),
                                _RowItem(
                                  label: "net_profit".tr,
                                  value: netProfitFormatted,
                                  showRiyal: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String formatNumber(num? number, {int decimals = 2}) {
    if (number == null) return "0.00";
    final isArabic = LocalStorage_language().read() == "ar";
    final format = NumberFormat.decimalPattern(isArabic ? "ar" : "en");
    format.minimumFractionDigits = decimals;
    format.maximumFractionDigits = decimals;
    return format.format(number);
  }

  String _localizedOrdinal(int number) {
    final isArabic = Get.locale?.languageCode == 'ar';
    if (isArabic) {
      const arabicOrdinals = [
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      ];
      return arabicOrdinals[number - 1].tr;
    } else {
      switch (number) {
        case 1:
          return "1st";
        case 2:
          return "2nd";
        case 3:
          return "3rd";
        default:
          return "${number}th";
      }
    }
  }
}

class _RowItem extends StatelessWidget {
  final String label;
  final String value;
  final bool showRiyal;

  const _RowItem({
    required this.label,
    required this.value,
    this.showRiyal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Text(
          label,
          style: context.typography.bodyStrongMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),

        /// Value + Riyal icon
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (showRiyal)
              Padding(
                padding: EdgeInsets.only(right: 4.w, top: 2.h),
                child: SvgPicture.asset(
                  IconsConstants.riyal,
                  width: 14.w,
                  height: 14.h,
                  color: AppColors.content_primary,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
