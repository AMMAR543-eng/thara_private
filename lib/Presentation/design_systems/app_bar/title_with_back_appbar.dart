import '../../../index/index_main.dart';

class TitleWithBackAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? titleColor;

  const TitleWithBackAppbar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.backgroundColor,
    this.titleColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        color: backgroundColor ?? AppColors.white,
        child: SafeArea(
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.border_natural_normal.withValues(alpha: 0.6),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            height: preferredSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// 🔹 Back button (left)
                if (showBackButton)
                  GestureDetector(
                    onTap: () => Get.back(),
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,

                          color: AppColors.content_brand_secondary,
                        ),

                        SizedBox(width: 8.w),
                      ],
                    ),
                  )
                else
                  SizedBox(width: 40.w),

                /// 🔹 Centered title
                Text(
                  title,
                  style: context.typography.header3xLarge.copyWith(
                    color: titleColor ?? AppColors.content_brand_secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),

                /// 🔹 Right placeholder for alignment
                SizedBox(width: 40.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
