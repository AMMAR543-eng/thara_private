import '../../../../../index/index_main.dart';

class DatePickerTabsWidget extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;

  const DatePickerTabsWidget({Key? key, this.onTabChanged}) : super(key: key);

  @override
  State<DatePickerTabsWidget> createState() => _DatePickerTabsWidgetState();
}

class _DatePickerTabsWidgetState extends State<DatePickerTabsWidget> {
  final List<Map<String, dynamic>> _tabs = [
    {"text": "التقويم الميلادي", "index": 0},
    {"text": "التقويم الهجري", "index": 1},
  ];

  int selectedIndex = 0;

  void _handleTabTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onTabChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: _tabs.map((tab) {
          final int index = tab["index"];
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => _handleTabTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  tab["text"],
                  style: context.typography.bodyMedium.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textDefault,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
