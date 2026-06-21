import 'package:intl/intl.dart';

import '../../../../index/index_main.dart';

class OpportunityCardAltWidget extends StatelessWidget {
  final OpportunitiesItemsEntity opportunity;
  final VoidCallback? onTap;

  const OpportunityCardAltWidget({
    super.key,
    required this.opportunity,
    this.onTap,
  });

  /// ✅ Locale-aware number formatter
  String formatNumber(num? number, {int decimals = 0}) {
    if (number == null) return "0";
    final isArabic = LocalStorage_language().read() == "ar";
    final format = NumberFormat.decimalPattern(isArabic ? "ar" : "en");
    format.minimumFractionDigits = decimals;
    format.maximumFractionDigits = decimals;
    return format.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final projectName = opportunity.projectName ?? "investment_project".tr;
    final owner = opportunity.conflictOfInteres ?? "by_undefined_company".tr;
    final score = opportunity.score ?? "";

    final amount = formatNumber(opportunity.principalAmount, decimals: 0);
    final interest = formatNumber(
      double.tryParse(opportunity.interestPercentage ?? "0"),
      decimals: 1,
    );
    final coverage = formatNumber(opportunity.collectedPercentage, decimals: 0);
    final daysLeft = formatNumber(
      double.tryParse(opportunity.daysToEnd?.toString() ?? "0"),
    );

    final logoUrl = null;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 360.w,
        margin: EdgeInsets.only(left: 2.w, top: 10.h, bottom: 15.h, right: 2.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 🔹 Title + Logo
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.h,
                  width: 60.h,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(0.r),
                    border: Border.all(
                      color: AppColors.border_natural_normal,
                      width: 0.5,
                    ),
                  ),
                  child: Image.asset(
                    Images.login_image,
                    height: 60.h,
                    width: 55.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${'by'.tr} $owner",
                        style: context.typography.bodyLarge.copyWith(
                          color: AppColors.tertiary,
                        ),
                      ),
                      Text(
                        projectName,
                        style: context.typography.bodyStrongLarge.copyWith(
                          color: AppColors.content_primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            /// 🔹 Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DetailItem(
                  title: "fund_goal".tr,
                  value: amount,
                  show_icon: true,
                ),
                _DetailItem(
                  title: "return_on_investment".tr,
                  value: "$interest %",
                ),
                _DetailItem(title: "risk_rating".tr, value: score),
              ],
            ),

            SizedBox(height: 16.h),

            /// 🔹 Coverage bar
            AnimatedProgressBarValue(
              value: (double.tryParse(coverage.replaceAll(',', '')) ?? 0) / 100,
              backgroundColor: AppColors.border_natural_normal,
              progressColor: AppColors.green_light,
            ),

            SizedBox(height: 8.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "coverage".tr,
                  style: context.typography.bodyMedium.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),
                Text(
                  "$coverage %",
                  style: context.typography.bodyMedium.copyWith(
                    color: AppColors.content_secondary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            /// 🔹 Remaining days (hide if zero)
            if (daysLeft != "0")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "days_left".tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.tertiary,
                    ),
                  ),
                  Text(
                    "$daysLeft ${'day'.tr}",
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Detail Item
class _DetailItem extends StatelessWidget {
  final String title;
  final String value;
  final bool? show_icon;

  const _DetailItem({required this.title, required this.value, this.show_icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: context.typography.bodyStrongMedium.copyWith(
                color: AppColors.content_primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (show_icon == true) ...[
              SizedBox(width: 4.w),
              SvgPicture.asset(
                IconsConstants.riyal,
                width: 18.w,
                height: 18.h,
                color: AppColors.content_primary,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// 🔹 Risk Badge (localized)

/// ✅ Reusable Progress Bar
class AnimatedProgressBarValue extends StatelessWidget {
  final double value; // 0 → 1
  final Color backgroundColor;
  final Color progressColor;
  final Duration duration;

  const AnimatedProgressBarValue({
    super.key,
    required this.value,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = Colors.green,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value.clamp(0, 1)),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, animatedValue, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final barWidth = constraints.maxWidth;
            final progressWidth = barWidth * animatedValue;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                Container(
                  height: 8.h,
                  width: progressWidth,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
