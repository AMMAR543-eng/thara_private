import '../../../../../../index/index_main.dart';

class ShortcutButton extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onTap;

  const ShortcutButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.border_default),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0.h, bottom: 10.h),
              child: SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.h,
                color: Theme.of(Get.context!).brightness == Brightness.dark
                    ? Colors.white
                    : AppColors.primary,
              ),
            ),
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
