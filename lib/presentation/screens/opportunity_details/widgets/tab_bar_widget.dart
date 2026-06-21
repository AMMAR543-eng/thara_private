import '../../../../index/index_main.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<int> enabledTabs;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.enabledTabs = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          final isEnabled = enabledTabs.contains(index);

          return Expanded(
            child: GestureDetector(
              onTap: isEnabled ? () => onTabSelected(index) : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: context.typography.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.darkJungleGreen
                          : isEnabled
                              ? AppColors.grayMedium
                              : AppColors.grayLight, // disabled color
                    ),
                  ),
                  SizedBox(height: 15.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 7.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  Container(height: 1, color: AppColors.greyLight),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
