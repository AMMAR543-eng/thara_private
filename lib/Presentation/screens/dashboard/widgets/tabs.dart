import '../../../../../index/index_main.dart';
import '../all_forsa/all_forsa_controller.dart';

class OpportunityTabsWidget extends StatelessWidget {
  final OpportunitiesController controller;

  const OpportunityTabsWidget({Key? key, required this.controller})
    : super(key: key);

  final List<Map<String, dynamic>> _tabs = const [
    {"text": "available_opportunities", "index": 0},
    {"text": "upcoming_opportunities", "index": 1},
    {"text": "completed_opportunities", "index": 2},
  ];

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _tabs.map((tab) {
                final int index = tab["index"];
                final bool isSelected = controller.tab_index == index;

                return GestureDetector(
                  onTap: () => controller.tabsActions(index),
                  child: Text(
                    (tab["text"] as String).tr, // ✅ FIX
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? AppColors.action_primary_normal
                          : AppColors.content_secondary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Stack(
            children: [
              Container(
                height: 2,
                width: double.infinity,
                color: AppColors.border_natural_normal.withValues(alpha: 0.4),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: _getAlignment(controller.tab_index, isRtl),
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

  Alignment _getAlignment(int index, bool isRtl) {
    if (isRtl) {
      if (index == 0) return Alignment.centerRight;
      if (index == 1) return Alignment.center;
      return Alignment.centerLeft;
    } else {
      if (index == 0) return Alignment.centerLeft;
      if (index == 1) return Alignment.center;
      return Alignment.centerRight;
    }
  }
}
