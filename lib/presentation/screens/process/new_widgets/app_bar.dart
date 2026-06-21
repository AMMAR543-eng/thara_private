import 'package:thara/Presentation/screens/dashboard/widgets/tabs.dart';
import 'package:thara/Presentation/screens/process/new_widgets/custom_tabs.dart';
import '../../../../index/index_main.dart';

class ProcessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ProcessController controller;
  int? selectedTab;

  ProcessAppBar({
    super.key,
    required this.title,
    required this.controller,
    required this.selectedTab,
  });

  // ✅ This fixes the “Missing concrete implementation” error
  @override
  Size get preferredSize => Size.fromHeight(110.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 110.h,
      titleSpacing: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Title
                Text(
                  title,
                  style: context.typography.header3xLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),

                /// Notification Icon
                Row(
                  children: [
                    // Row(
                    //   children: [
                    //     Stack(
                    //       clipBehavior: Clip.none,
                    //       children: [
                    //         SvgPicture.asset(
                    //           IconsConstants.notification,
                    //           height: 28,
                    //           width: 28,
                    //         ),
                    //         Positioned(
                    //           right: -2,
                    //           top: -2,
                    //           child: Container(
                    //             width: 10,
                    //             height: 10,
                    //             decoration: const BoxDecoration(
                    //               color: AppColors.errorForeground,
                    //               shape: BoxShape.circle,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(width: 15),
                    InkWell(
                      onTap: () => Get.toNamed(settingNewView),
                      child: const ProfileIconWidget(size: 40),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 🔹 Tabs below the title
          IncomeOutcomeTabsWidget(
            selectedIndex: selectedTab ?? 0,
            onTabSelected: (index) {
              selectedTab = index;
              // controller.tab_index = index;
              controller.tabsActions(index);
              controller.update();
              // TODO: handle logic for deposit or withdraw here
            },
          ),
        ],
      ),
    );
  }
}
