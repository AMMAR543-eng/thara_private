import '../../../../index/index_main.dart';

class PaymentScheduleTab extends StatelessWidget {
  final List<PaymentsScheduleEntity> schedule;
  final double platformFeePercent;

  const PaymentScheduleTab({
    super.key,
    required this.schedule,
    this.platformFeePercent = 0.23,
  });

  @override
  Widget build(BuildContext context) {
    final headers = [
      '#',
      'payment_month'.tr,
      'principal_amount'.tr,
      'profit'.tr,
      'platform_fee'.tr,
      'net_profit'.tr,
    ];

    return Column(
      children: [
        _PaymentHeader(headers),
        ...schedule.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final item = entry.value;

          final double interest = double.tryParse(item.interest ?? '0') ?? 0;
          final double principle = double.tryParse(item.principle ?? '0') ?? 0;

          final double platformFee = double.parse(
            (interest * platformFeePercent).toStringAsFixed(2),
          );
          final double netProfit = double.parse(
            (interest - platformFee).toStringAsFixed(2),
          );

          return _PaymentRow([
            index.toString(),
            "T+${item.monthOffset ?? '-'}",
            principle.toStringAsFixed(2),
            interest.toStringAsFixed(2),
            platformFee.toStringAsFixed(2),
            netProfit.toStringAsFixed(2),
          ]);
        }),
        PaymentSummaryRow(schedule, platformFeePercent),
      ],
    );
  }
}

class _PaymentHeader extends StatelessWidget {
  final List<String> headers;

  const _PaymentHeader(this.headers);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(25.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Row(
        children: headers
            .map(
              (e) => Expanded(
                child: Text(
                  e,
                  textAlign: TextAlign.center,
                  style: context.typography.bodyMedium,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final List<String> cells;

  const _PaymentRow(this.cells);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: cells
            .map(
              (cell) => Expanded(
                child: Text(
                  cell,
                  textAlign: TextAlign.center,
                  style: context.typography.bodyMedium.copyWith(
                    color: AppColors.background_black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class PaymentSummaryRow extends StatelessWidget {
  final List<PaymentsScheduleEntity> schedule;
  final double platformFeePercent;

  const PaymentSummaryRow(this.schedule, this.platformFeePercent, {super.key});

  @override
  Widget build(BuildContext context) {
    double totalPrinciple = 0;
    double totalInterest = 0;
    double totalPlatformFee = 0;
    double totalNetProfit = 0;

    for (final item in schedule) {
      final interest = double.tryParse(item.interest ?? '0') ?? 0;
      final principle = double.tryParse(item.principle ?? '0') ?? 0;
      final platformFee = interest * platformFeePercent;
      final netProfit = interest - platformFee;

      totalPrinciple += principle;
      totalInterest += interest;
      totalPlatformFee += platformFee;
      totalNetProfit += netProfit;
    }

    return Container(
      padding: EdgeInsets.all(25.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children:
            [
                  'total'.tr,
                  '-',
                  totalPrinciple.toStringAsFixed(2),
                  totalInterest.toStringAsFixed(2),
                  totalPlatformFee.toStringAsFixed(2),
                  totalNetProfit.toStringAsFixed(2),
                ]
                .map(
                  (cell) => Expanded(
                    child: Text(
                      cell,
                      textAlign: TextAlign.center,
                      style: context.typography.bodyMedium.copyWith(
                        color: AppColors.background_black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
