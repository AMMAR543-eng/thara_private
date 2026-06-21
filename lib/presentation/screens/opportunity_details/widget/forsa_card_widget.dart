import 'package:intl/intl.dart';
import '../../../../index/index_main.dart';

class OpportunityDetailsCardWidget extends StatelessWidget {
  final OpportunitiesItemsEntity opportunity;
  final VoidCallback? onTap;
  final bool? show_view_button;

  final OpportunityDetailsController? opportunityDetailsController;
  final ScrollController? scrollController;
  final bool? from_details;

  const OpportunityDetailsCardWidget({
    super.key,
    required this.opportunity,
    this.onTap,
    this.scrollController,
    this.opportunityDetailsController,
    this.from_details,
    this.show_view_button,
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

    final amount = formatNumber(opportunity.principalAmount, decimals: 0);
    final interest = formatNumber(
      double.tryParse(opportunity.interestPercentage ?? "0"),
      decimals: 1,
    );
    final coverage = formatNumber(opportunity.collectedPercentage, decimals: 0);

    final duration = opportunity.duration?.toString() ?? "-";
    final riskValue = opportunity.score ?? "";
    final daysLeft = formatNumber(
      double.tryParse(opportunity.daysToEnd?.toString() ?? "0"),
    );
    final imageUrl = opportunity.projectImage?.isNotEmpty == true
        ? opportunity.projectImage!.first.url
        : "";

    return InkWell(
      onTap: onTap,
      child: Container(
        width: ScreenUtil().screenWidth,
        margin: EdgeInsets.only(left: 8.w, top: 10.h, bottom: 15.h, right: 8.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.border_natural_normal),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 🔹 Project image + logo
            Stack(
              children: [
                Container(height: 230.h),
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
                Positioned(
                  bottom: 10.h,
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
                Positioned(
                  bottom: 0.h,
                  right: LocalStorage_language().read() == "en" ? null : 95.w,
                  left: LocalStorage_language().read() == "en" ? 95.w : null,
                  child: SizedBox(
                    height: 58.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 260.w,
                          child: Text(
                            projectName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.typography.bodyMedium.copyWith(
                              color: AppColors.tertiary,
                            ),
                          ),
                        ),
                        Text(
                          opportunity.id ?? "",
                          style: context.typography.bodyStrongMedium.copyWith(
                            color: AppColors.content_primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Divider(
              color: AppColors.border_natural_normal,
              thickness: 0.3,
            ),

            /// 🔹 Details Section
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 10.w,
                right: 10.w,
                bottom: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// 🔹 Row 1
                  Row(
                    children: [
                      Expanded(
                        child: _InfoItem(
                          label: "fund_duration".tr,
                          value: "$duration ${'month'.tr}",
                          alignCenter: true,
                        ),
                      ),
                      Expanded(
                        child: _RiskItem(
                          value: riskValue,
                          alignCenter: true, // لو حابب
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// 🔹 Row 2
                  Row(
                    children: [
                      Expanded(
                        child: _InfoItem(
                          label: "annual_return".tr,
                          value: "$interest%",
                          alignCenter: true,
                        ),
                      ),
                      Expanded(
                        child: _InfoItem(
                          label: "fund_size".tr,
                          value: amount,
                          show_icon: true,
                          alignCenter: true,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  /// 🔹 Row 3
                  _InfoItem(
                    label: "distributions".tr,
                    value: "quarterly".tr,
                    alignCenter: true,
                  ),

                  SizedBox(height: 16.h),

                  const Divider(
                    color: AppColors.border_natural_normal,
                    thickness: 0.3,
                  ),

                  /// 🔹 Coverage Bar
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 15.h),
                    child: Column(
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
                      ],
                    ),
                  ),

                  /// 🔹 Remaining days
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.info,
                              color: AppColors.greyDark,
                              size: 18,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              "days_left".tr,
                              style: context.typography.bodyMedium.copyWith(
                                color: AppColors.tertiary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "$daysLeft ${'day'.tr}",
                          style: context.typography.bodyMedium.copyWith(
                            color: AppColors.content_secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 View Button (Optional)
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

class _RiskItem extends StatelessWidget {
  final String value;
  final bool alignCenter;

  const _RiskItem({required this.value, this.alignCenter = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "risk_rating".tr,
          textAlign: alignCenter ? TextAlign.center : TextAlign.start,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.green_light.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.green_light,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  final bool? show_icon;
  final bool alignCenter;

  const _InfoItem({
    required this.label,
    required this.value,
    this.show_icon,
    this.alignCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: alignCenter ? TextAlign.center : TextAlign.start,
          style: context.typography.bodyStrongMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: context.typography.bodyLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (show_icon == true) ...[
              SizedBox(width: 4.w),
              SvgPicture.asset(
                IconsConstants.riyal,
                width: 18.w,
                height: 18.h,
                color: AppColors.primary,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
