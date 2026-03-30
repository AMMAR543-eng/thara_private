import '../../../../index/index_main.dart';

enum StatType { money, investmentsCount }

class InvestmentSummaryWidget extends StatelessWidget {
  const InvestmentSummaryWidget({super.key});

  // ---- helpers ----
  Widget _shimmerBar() {
    return Shimmer.fromColors(
      baseColor: AppColors.border_default,
      highlightColor: AppColors.border_natural_normal,
      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.border_default,
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
    );
  }

  Widget shimmerValue() {
    return Shimmer.fromColors(
      baseColor: AppColors.border_default,
      highlightColor: AppColors.border_natural_normal,
      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.border_default,
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );
  }

  String _formatNum(num? v) {
    if (v == null) return '';
    final s = v.toStringAsFixed(v % 1 == 0 ? 0 : 2);
    final parts = s.split('.');
    final intPart = parts.first.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
  }

  Widget _valueWithVisuals({
    required BuildContext context,
    required StatType type,
    required num value,
    required String? currencySvg,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (type == StatType.money)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatNum(value),
                style: context.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.content_primary,
                ),
              ),
              if (currencySvg != null)
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 6.w),
                  child: SvgPicture.asset(
                    currencySvg,
                    width: 18.w,
                    height: 18.w,
                    colorFilter: ColorFilter.mode(
                      AppColors.content_secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          )
        else
          Text.rich(
            TextSpan(
              text: _formatNum(value),
              style: context.typography.bodyLarge.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.content_primary,
              ),
              children: [
                TextSpan(
                  text: ' ${'investment_word'.tr}',
                  style: context.typography.bodyMedium.copyWith(
                    color: AppColors.content_secondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _card({
    required BuildContext context,
    required String label,
    required StatType type,
    required num? value,
    String? currencySvg,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_default),
        boxShadow: [
          BoxShadow(
            color: AppColors.border_default.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label.tr,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
              ),
            ),
          ),
          (value == null)
              ? _shimmerBar()
              : _valueWithVisuals(
                  context: context,
                  type: type,
                  value: value,
                  currencySvg: currencySvg,
                ),
        ],
      ),
    );
  }

  Widget buildCard({required String label, required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_default),
        boxShadow: [
          BoxShadow(
            color: AppColors.border_default.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label.tr,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
              ),
            ),
          ),
          shimmerValue(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (c) {
        final t = c.tradeAccountEntity;

        final items = <Widget>[
          _card(
            context: context,
            label: 'active_investment_amount_count',
            type: StatType.investmentsCount,
            value: t?.reserved,
          ),
          _card(
            context: context,
            label: 'available_cash',
            type: StatType.money,
            value: t?.available,
            currencySvg: IconsConstants.riyal,
          ),
          _card(
            context: context,
            label: 'active_investment_amounts',
            type: StatType.money,
            value: t?.invested,
            currencySvg: IconsConstants.riyal,
          ),
          _card(
            context: context,
            label: 'total_investment_count',
            type: StatType.investmentsCount,
            value: (c.investmentEntity == null)
                ? null
                : c.investmentItems.length,
          ),
          _card(
            context: context,
            label: 'total_expected_profit',
            type: StatType.money,
            value: t?.expectedProfit,
            currencySvg: IconsConstants.riyal,
          ),
          // _card(
          //   context: context,
          //   label: 'active_investments',
          //   type: StatType.investmentsCount,
          //   value: t?.pending,
          // ),
          _card(
            context: context,
            label: 'total_invested_amount',
            type: StatType.money,
            value: t?.total,
            currencySvg: IconsConstants.riyal,
          ),
          _card(
            context: context,
            label: 'total_realized_profit',
            type: StatType.money,
            value: t?.blocked,
            currencySvg: IconsConstants.riyal,
          ),
        ];

        final itemsShimmer = [
          'active_investment_amount_count',
          'available_cash',
          'active_investment_amounts',
          'total_investment_count',
          'total_expected_profit',
          //  'active_investments',
          'total_invested_amount',
          'total_realized_profit',
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'your_investment_summary'.tr,
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.content_primary,
              ),
            ),
            SizedBox(height: 16.h),
            t == null
                ? GridView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (context, index) {
                      return buildCard(
                        label: itemsShimmer[index],
                        context: context,
                      );
                    },
                  )
                : GridView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 1.6,
                    ),
                    itemBuilder: (_, i) => items[i],
                  ),
          ],
        );
      },
    );
  }
}
