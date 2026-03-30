import 'package:thara/index/index_main.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final void Function()? onTap;

  const SettingsItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = LocalStorage_language().read() == 'ar';

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              fit: BoxFit.contain,
              height: 25.h,
              width: 25.w,
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.primary,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(Get.context!).brightness == Brightness.dark
                  ? Colors.white
                  : AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
