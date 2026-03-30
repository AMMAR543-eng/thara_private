import '../../../../../index/index_main.dart';

class IncomeOutcomeTabsWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const IncomeOutcomeTabsWidget({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  State<IncomeOutcomeTabsWidget> createState() =>
      _IncomeOutcomeTabsWidgetState();
}

class _IncomeOutcomeTabsWidgetState extends State<IncomeOutcomeTabsWidget> {
  final List<Map<String, dynamic>> _tabs = [
    {
      "text": "deposit_operations".tr,
      "icon": IconsConstants.income, // ✅ deposit SVG
      "index": 0,
    },
    {
      "text": "withdraw_operations".tr,
      "icon": IconsConstants.outcome, // ✅ withdraw SVG
      "index": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          // ───────────── Tabs Row ─────────────
          SizedBox(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _tabs.map((tab) {
                final int index = tab["index"];
                final bool isSelected = widget.selectedIndex == index;

                return GestureDetector(
                  onTap: () => widget.onTabSelected(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            tab["icon"],
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? AppColors.action_primary_normal
                                  : AppColors.content_secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tab["text"],
                            style: context.typography.bodyMedium.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.action_primary_normal
                                  : AppColors.content_secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // ───────────── Underline Indicator ─────────────
          Stack(
            children: [
              // Gray baseline across full width
              Container(
                height: 2,
                width: double.infinity,
                color: AppColors.border_natural_normal.withOpacity(0.4),
              ),

              // Animated underline for active tab
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: _getAlignment(widget.selectedIndex, isRtl),
                child: Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width / _tabs.length,
                  color: AppColors.action_primary_normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 Calculates underline alignment based on language direction
  Alignment _getAlignment(int index, bool isRtl) {
    if (isRtl) {
      // Reverse for Arabic
      return index == 0 ? Alignment.centerRight : Alignment.centerLeft;
    } else {
      // Normal for English
      return index == 0 ? Alignment.centerLeft : Alignment.centerRight;
    }
  }
}
