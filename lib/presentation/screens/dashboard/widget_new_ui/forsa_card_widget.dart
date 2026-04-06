import 'package:intl/intl.dart';
import '../../../../index/index_main.dart';

class OpportunityCardWidget extends StatelessWidget {
  final OpportunitiesItemsEntity opportunity;
  final VoidCallback? onTap;
  final bool? show_view_button;
  final double? customWidth;
  final int? tab_index;

  final OpportunityDetailsController? opportunityDetailsController;
  final ScrollController? scrollController;
  final bool? from_details;

  const OpportunityCardWidget({
    super.key,
    required this.opportunity,
    this.onTap,
    this.customWidth,
    this.tab_index,
    this.scrollController,
    this.opportunityDetailsController,
    this.from_details,
    this.show_view_button,
  });

  /// ✅ Locale-aware number formatter (same as in OpportunityDetailsCardWidget)
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
    final projectId = opportunity.id ?? "";
    final owner = opportunity.conflictOfInteres ?? "by_undefined_company".tr;

    final amount = formatNumber(opportunity.principalAmount, decimals: 0);
    final interest = formatNumber(
      double.tryParse(opportunity.interestPercentage ?? "0"),
      decimals: 1,
    );
    final coverage = formatNumber(opportunity.collectedPercentage, decimals: 0);
    final daysLeft = formatNumber(
      double.tryParse(opportunity.daysToEnd?.toString() ?? "0"),
    );

    final riskValue = opportunity.score ?? "";
    final imageUrl = opportunity.projectImage?.isNotEmpty == true
        ? opportunity.projectImage!.first.url
        : "";

    return InkWell(
      onTap: onTap,
      child: Container(
        width: customWidth ?? 330.w,
        margin: EdgeInsets.only(left: 8.w, top: 10.h, bottom: 15.h, right: 2.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 🔹 Project image + logo
            Stack(
              children: [
                Container(height: 220.h),
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.r),
                  ),
                  child: NetworkAttachmentImage(
                    url: imageUrl ?? "",
                    height: 165.h,
                    width: double.infinity,
                    boxFit: BoxFit.cover,
                  ),
                ),

                /// logo bottom right
                Positioned(
                  bottom: 0.h,
                  right: LocalStorage_language().read() == "en" ? null : 10.w,
                  left: LocalStorage_language().read() == "en" ? 10.w : null,
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      Images.login_image,
                      height: 60.h,
                      width: 55.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                /// title & owner
                Positioned(
                  bottom: 0.h,
                  right: LocalStorage_language().read() == "en" ? null : 95.w,
                  left: LocalStorage_language().read() == "en" ? 95.w : null,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Text(
                          projectName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.tertiary,
                          ),
                        ),
                      ),
                      Text(
                        projectId,
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

            /// 🔹 Details section
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 10.w,
                right: 10.w,
                bottom: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Funding info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _InfoItem(
                        label: "fund_size".tr,
                        value: amount,
                        show_icon: true,
                      ),
                      _InfoItem(label: "annual_return".tr, value: "$interest%"),
                      _InfoItem(label: "risk_rating".tr, value: riskValue),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  if (coverage != "0")

                    /// 🔹 Coverage bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedProgressBar(
                          value:
                              (double.tryParse(coverage.replaceAll(',', '')) ??
                                      0) /
                                  100,
                          backgroundColor: AppColors.border_natural_normal,
                          progressColor: AppColors.green_light,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                      ],
                    ),

                  //   if (daysLeft != "0" && tab_index != 1)
                  /// 🔹 Days left
                  tab_index == 1
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.info, color: AppColors.greyDark),
                              SizedBox(width: 6.w),
                              Text(
                                getTimeUntilStart(opportunity.startAt),
                                style: context.typography.bodyMedium.copyWith(
                                  color: AppColors.content_secondary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : (daysLeft != "0" && tab_index != 1)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.info,
                                        color: AppColors.greyDark,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        "days_left".tr,
                                        style: context.typography.bodyMedium
                                            .copyWith(
                                                color: AppColors.tertiary),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "$daysLeft ${'day'.tr}",
                                    style:
                                        context.typography.bodyMedium.copyWith(
                                      color: AppColors.content_secondary,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                ],
              ),
            ),

            /// 🔹 View opportunity button
            if (show_view_button == true)
              Padding(
                padding: EdgeInsets.only(
                  left: 15.0.w,
                  right: 15.0.w,
                  top: 3.h,
                  bottom: 10.h,
                ),
                child: PrimaryTextButton(
                  customBackgroundColor: AppColors.white,
                  onTap: () {
                    if (from_details == true) {
                      opportunityDetailsController?.reloadWithNewId(
                        scrollController ?? ScrollController(),
                        opportunity.id ?? "",
                      );
                    } else {
                      Get.to(
                        () => OpportunityDetailsView(id: opportunity.id ?? ""),
                        binding: Binding(),
                        duration: const Duration(milliseconds: 0),
                      );
                    }
                  },
                  customBorder: const BorderSide(
                    width: 1,
                    color: AppColors.border_natural_normal,
                  ),
                  label: Text(
                    "view_opportunity".tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool? show_icon;

  const _InfoItem({required this.label, required this.value, this.show_icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: context.typography.bodyMedium.copyWith(
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

/// ✅ Progress bar helper widget
class AnimatedProgressBar extends StatelessWidget {
  final double value; // 0 → 1
  final Color backgroundColor;
  final Color progressColor;
  final Duration duration;

  const AnimatedProgressBar({
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

  /// ✅ Calculate time difference between now and startAt
}

String getTimeUntilStart(String? startAt) {
  if (startAt == null || startAt.isEmpty) return "";

  try {
    final startDate = DateTime.parse(startAt);
    final now = DateTime.now();
    final diff = startDate.difference(now);

    if (diff.isNegative) return ""; // already started

    final days = diff.inDays;
    final hours = diff.inHours % 24;

    final isArabic = LocalStorage_language().read() == "ar";

    if (isArabic) {
      return "يبدأ الاستثمار بعد ${days > 0 ? "$days أيام و " : ""}$hours ساعة من الآن";
    } else {
      return "Starts in ${days > 0 ? "$days days and " : ""}$hours hours from now";
    }
  } catch (e) {
    return "";
  }
}
