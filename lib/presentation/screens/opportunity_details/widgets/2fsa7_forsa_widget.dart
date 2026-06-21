import 'package:thara/Presentation/screens/opportunity_details/widgets/html_viewer.dart';
import '../../../../index/index_main.dart';

class EfsahWidgetTab extends StatefulWidget {
  final OpportunityDetailsController controller;

  const EfsahWidgetTab(this.controller, {super.key});

  @override
  State<EfsahWidgetTab> createState() => _EfsahWidgetTabState();
}

class _EfsahWidgetTabState extends State<EfsahWidgetTab> {
  bool isExpanded = true; // ✅ Default expanded

  @override
  Widget build(BuildContext context) {
    final opportunity = widget.controller.opportunitiesItemsEntity;
    final aboutText = opportunity?.conflictOfInteres ?? "";

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
          /// 🔹 Header (Title + Arrow)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "disclosures".tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.5 : 0, // rotates arrow up/down
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.content_brand_secondary,
                    size: 28.sp,
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Divider
          if (isExpanded)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                color: AppColors.greyDark.withValues(alpha: 0.2),
                height: 1,
              ),
            ),

          /// 🔹 Expanded Text
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: HtmlViewer(htmlData: aboutText),
            secondChild: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
