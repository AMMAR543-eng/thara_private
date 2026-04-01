import '../../../../../index/index_main.dart';

class TransactionTabsWidget extends StatefulWidget {
  final ProcessController controller;

  const TransactionTabsWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<TransactionTabsWidget> createState() => _TransactionTabsWidgetState();
}

class _TransactionTabsWidgetState extends State<TransactionTabsWidget> {
  final List<Map<String, dynamic>> _tabs = [
    {"text": "deposit_operations".tr, "index": 0},
    {"text": "withdraw_operations".tr, "index": 1},
  ];

  void _handleTabTap(int index) {
    widget.controller.tabsActions(index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorMappingImpl();
    final bool isArabic = LocalStorage_language().read() == "ar";

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
      child: SizedBox(
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _tabs.map((tab) {
            final int index = tab["index"];
            final bool isSelected = widget.controller.tab_index == index;

            // Dynamic rounded corners based on language direction
            BorderRadius borderRadius;
            if (index == 0) {
              borderRadius = isArabic
                  ? const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    );
            } else {
              borderRadius = isArabic
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    );
            }

            return Expanded(
              child: GestureDetector(
                onTap: () => _handleTabTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : colors.background_neutral_default,
                    borderRadius: borderRadius,
                  ),
                  child: Center(
                    child: Text(
                      tab["text"],
                      style: context.typography.font40White.copyWith(
                        color: isSelected ? colors.white : colors.textDefault,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
