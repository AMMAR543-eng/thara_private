import 'package:intl/intl.dart';
import '../../../../index/index_main.dart';

class InvestmentTransactionsWidget extends StatelessWidget {
  const InvestmentTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return GetBuilder<DashboardController>(
      builder: (c) {
        final items = c.investmentItems;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Header Row
            Padding(
              padding: EdgeInsets.only(top: 20.h, right: 16.w, left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'investment_transactions'.tr,
                    style: context.typography.headerXLarge.copyWith(
                      color: AppColors.content_brand_secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        InvestmentTransactionsFilterSheet.open(context, c),
                    child: Row(
                      children: [
                        Text(
                          "filter".tr,
                          style: context.typography.bodyMedium.copyWith(
                            color: AppColors.action_primary_normal,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        SvgPicture.asset(
                          IconsConstants.search,
                          width: 20.w,
                          height: 20.w,
                          colorFilter: ColorFilter.mode(
                            AppColors.content_primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            /// 🔹 Horizontal Scrollable Cards
            if (items.isEmpty)
              Container(
                margin: EdgeInsets.only(top: 16.h, bottom: 12.h),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border_default),
                ),
                child: Center(
                  child: Text(
                    'no_investments_now'.tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
                    ),
                  ),
                ),
              )
            else
              SizedBox(
                height: 620.h,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 10.w),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (_, i) =>
                      _investmentCard(context, items[i], width: 330.w),
                ),
              ),
          ],
        );
      },
    );
  }

  /// 🔹 Investment Card — Column style (label above value)
  Widget _investmentCard(
    BuildContext context,
    InvestmentTransactionItemEntity item, {
    double? width,
  }) {
    return Container(
      width: width ?? 320.w,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.border_default.withValues(alpha: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.border_default.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${item.id ?? '--'}',
              style: context.typography.header4xLarge.copyWith(
                color: AppColors.tertiary,
              ),
            ),
            SizedBox(height: 12.h),
            _labelValue(
              context,
              'opportunity_name'.tr,
              item.projectName ?? '-',
            ),
            _moneyValue(context, 'investment_amount'.tr, item.totalPrice ?? 0),
            _labelValue(
              context,
              'investment_duration'.tr,
              '${item.duration ?? 0} شهر',
            ),
            _labelValue(
              context,
              'investment_date'.tr,
              _formatDate(item.createdAt),
            ),
            _moneyValue(
              context,
              'expected_profit'.tr,
              item.expectedProfit ?? 0,
            ),
            _moneyValue(
              context,
              'realized_profit_in_wallet'.tr,
              item.gainedNetProfit ?? 0,
            ),
            _moneyValue(context, 'net_profit'.tr, item.netProfit ?? 0),
            _labelValue(context, 'status'.tr, _statusName(item.status).tr),
          ],
        ),
      ),
    );
  }

  /// 🔹 Label above value
  Widget _labelValue(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.tertiary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Label above value with ريال SVG icon
  Widget _moneyValue(BuildContext context, String label, num amount) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.tertiary,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _formatNum(amount),
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(
                IconsConstants.riyal,
                width: 20.w,
                height: 20.w,
                colorFilter: ColorFilter.mode(
                  AppColors.content_primary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Formatter Helpers
  String _formatNum(num v) {
    final s = v.toStringAsFixed(v % 1 == 0 ? 0 : 2);
    final parts = s.split('.');
    final intPart = parts.first.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
  }

  String _formatDate(String? date) {
    if (date == null) return '-';
    try {
      final d = DateTime.parse(date);
      return DateFormat('yyyy/MM/dd').format(d);
    } catch (_) {
      return date;
    }
  }

  /// 🔹 Localized status names
  String _statusName(String? status) {
    switch (status) {
      case 'active':
        return 'status_active';
      case 'closed':
        return 'status_closed';
      case 'on_hold':
        return 'status_on_hold';
      case 'canceled':
        return 'status_canceled';
      default:
        return '-';
    }
  }
}
