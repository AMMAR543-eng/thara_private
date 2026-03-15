import '../../../index/index_main.dart';

/// 🔹 Base AppBar that defines common structure & behavior
abstract class BaseAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showProfile;
  final bool showNotification;
  final Widget? bottomWidget;

  const BaseAppBar({
    super.key,
    required this.title,
    this.showProfile = true,
    this.showNotification = true,
    this.bottomWidget,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: preferredSize.height,
      titleSpacing: 0,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTopRow(context),
          if (bottomWidget != null) bottomWidget!,
        ],
      ),
      bottom: bottomWidget == null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 2,
                color: AppColors.border_natural_normal.withValues(alpha: 0.4),
              ),
            )
          : null,
    );
  }

  /// 🔸 Common header row with title + icons
  Widget _buildTopRow(BuildContext context) {
    return Padding(
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

          /// Right-side icons
          Row(
            children: [
              // if (showNotification)
              //   Stack(
              //     clipBehavior: Clip.none,
              //     children: [
              //       InkWell(
              //         onTap: () => Get.toNamed(notificationsView),
              //         child: SvgPicture.asset(
              //           IconsConstants.notification,
              //           height: 28,
              //           width: 28,
              //         ),
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
              if (showProfile) ...[
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => Get.toNamed(settingNewView),
                  child: const ProfileIconWidget(size: 40),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
