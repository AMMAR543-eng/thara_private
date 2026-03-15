import 'package:thara/Presentation/screens/dashboard/widgets/tabs.dart';
import '../../../../index/index_main.dart';

class AllForsaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final OpportunitiesController controller;
  final bool? showBackAndLimitedUI;

  const AllForsaAppBar({
    super.key,
    required this.title,
    required this.controller,
    this.showBackAndLimitedUI = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 110,
      titleSpacing: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 🔹 Left side (Back icon or Title)
                Row(
                  children: [
                    showBackAndLimitedUI != null
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.content_brand_secondary,
                            ),
                            onPressed: () => Get.back(),
                          )
                        : const SizedBox(height: 1, width: 1),
                    Text(
                      title,
                      style: context.typography.header3xLarge.copyWith(
                        color: AppColors.content_brand_secondary,
                      ),
                    ),
                  ],
                ),

                /// 🔹 Right side (Notification or Full actions)
                Row(
                  children: [
                    // InkWell(
                    //   onTap: () => Get.toNamed(notificationsView),
                    //   child: Stack(
                    //     clipBehavior: Clip.none,
                    //     children: [
                    //       SvgPicture.asset(
                    //         IconsConstants.notification,
                    //         height: 28,
                    //         width: 28,
                    //       ),
                    //       Positioned(
                    //         right: -2,
                    //         top: -2,
                    //         child: Container(
                    //           width: 10,
                    //           height: 10,
                    //           decoration: const BoxDecoration(
                    //             color: AppColors.errorForeground,
                    //             shape: BoxShape.circle,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    if (showBackAndLimitedUI == null) ...[
                      const SizedBox(width: 10, height: 10),
                      InkWell(
                        onTap: () => Get.toNamed(settingNewView),
                        child: const ProfileIconWidget(size: 40),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          /// 🔹 Tabs
          GetBuilder<OpportunitiesController>(
            builder: (controller) {
              return OpportunityTabsWidget(controller: controller);
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
