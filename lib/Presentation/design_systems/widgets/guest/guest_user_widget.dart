import '../../../../index/index_main.dart';

class GuestUserDialogWidget extends StatelessWidget {
  const GuestUserDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🖼️ Guest Illustration
            Image.asset(
              Images.no_data,
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.h),

            /// 📝 Message
            Text(
              "guest_user_message".tr,
              style: context.typography.bodyStrongLarge.copyWith(
                color: AppColors.text_primary_paragraph,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 32.h),

            /// 🔘 Login Button
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: PrimaryTextButton(
                onTap: () => Get.offAllNamed(loginScreen),
                label: Text(
                  "login".tr,
                  style: context.typography.bodyLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
                customBackgroundColor: AppColors.action_primary_normal,
                appButtonSize: AppButtonSize.xlarge,
              ),
            ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
