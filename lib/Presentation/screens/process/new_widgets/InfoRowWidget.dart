import '../../../../index/index_main.dart';

class InfoRowWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool showCurrencyIcon;

  const InfoRowWidget({
    super.key,
    required this.title,
    required this.value,
    this.showCurrencyIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: context.typography.bodyStrongMedium.copyWith(
                  color: AppColors.content_primary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showCurrencyIcon)
              Padding(
                padding: EdgeInsets.only(right: 4.w),
                child: SvgPicture.asset(
                  IconsConstants.riyal,
                  width: 20.w,
                  height: 20.h,
                  color: AppColors.content_primary,

                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// 🔹 Status Label Row
class StatusRowWidget extends StatelessWidget {
  final String statusText;

  const StatusRowWidget({super.key, required this.statusText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "request_status".tr,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.tertiary,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: 80.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.successBackground,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.circle,
                size: 10,
                color: AppColors.successForeground,
              ),
              SizedBox(width: 6.w),
              Text(
                statusText,
                style: context.typography.bodyStrongMedium.copyWith(
                  color: AppColors.successForeground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 🔴 Cancel Button
class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CancelButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border_natural_normal, width: 1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.errorForeground,
          padding: EdgeInsets.symmetric(vertical: 10.h),
        ),
        child: Text(
          "cancel".tr,
          style: context.typography.bodyStrongLarge.copyWith(
            color: AppColors.errorForeground,
          ),
        ),
      ),
    );
  }
}
