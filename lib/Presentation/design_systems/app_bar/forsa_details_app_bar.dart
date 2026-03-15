import '../../../../index/index_main.dart';

class ForsaDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onBack;
  final VoidCallback? onShare;

  const ForsaDetailsAppBar({
    super.key,
    required this.title,
    required this.subTitle,
    this.onBack,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: 70.h, // ✅ keep compact height
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.typography.headerLarge.copyWith(
              color: AppColors.content_primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subTitle,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),
        ],
      ),

      leading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.content_brand_secondary,
        ),
      ),

      actions: [
        IconButton(
          onPressed: onShare,
          icon: SvgPicture.asset(
            IconsConstants.share_icon,
            height: 22.h,
            width: 22.h,
            color: AppColors.content_brand_secondary,
          ),
        ),
      ],

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          height: 1.h,
          color: AppColors.border_natural_normal.withOpacity(0.2),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
