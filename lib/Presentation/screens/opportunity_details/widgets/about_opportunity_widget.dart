import 'package:thara/Presentation/screens/opportunity_details/widgets/html_viewer.dart';
import '../../../../index/index_main.dart';

class AboutOpportunityTab extends StatefulWidget {
  final OpportunityDetailsController controller;

  const AboutOpportunityTab(this.controller, {super.key});

  @override
  State<AboutOpportunityTab> createState() => _AboutOpportunityTabState();
}

class _AboutOpportunityTabState extends State<AboutOpportunityTab> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final opportunity = widget.controller.opportunitiesItemsEntity;

    final summary = opportunity?.projectSummary?.trim();
    final details = opportunity?.projectDetails?.trim();

    final hasSummary = summary != null && summary.isNotEmpty;
    final hasDetails = details != null && details.isNotEmpty;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_natural_normal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "about".tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.content_brand_secondary,
                    size: 28.sp,
                  ),
                ),
              ],
            ),
          ),

          if (isExpanded) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                color: AppColors.greyDark.withValues(alpha: 0.2),
                height: 1,
              ),
            ),

            /// 🔹 Summary
            if (hasSummary) ...[HtmlViewer(htmlData: summary)],

            /// 🔹 Divider between sections
            if (hasSummary && hasDetails)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Divider(
                  color: AppColors.greyDark.withValues(alpha: 0.2),
                ),
              ),

            /// 🔹 Details
            if (hasDetails) ...[HtmlViewer(htmlData: details)],
          ],
        ],
      ),
    );
  }
}
