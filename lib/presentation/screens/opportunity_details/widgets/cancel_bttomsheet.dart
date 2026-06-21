import '../../../../index/index_main.dart';

void showCancelConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => CancelConfirmationDialog(
      onConfirm: onConfirm,
      title: "withdraw_investment".tr,
      body: "withdraw_investment_confirmation".tr,
      confirm_text: "confirm".tr,
    ),
  );
}

class CancelConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String title;
  final String body;
  final bool? is_primary_btn;
  final String confirm_text;

  const CancelConfirmationDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    this.is_primary_btn,
    required this.confirm_text,
    required this.body,
  });

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
            /// 🔹 Icon (warning)
            SvgPicture.asset(IconsConstants.cancel),
            SizedBox(height: 16.h),

            /// 🔹 Title
            Text(
              title,
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.content_primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            /// 🔹 Description
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 24.h),
              child: Text(
                body,
                textAlign: TextAlign.center,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                  height: 1.6,
                ),
              ),
            ),

            /// 🔹 Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Cancel Button (outlined)
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: AppColors.border_natural_normal,
                      width: 1.2,
                    ),
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  child: Text(
                    "back".tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.background_black,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                /// Confirm Button
                is_primary_btn != null
                    ? SizedBox(
                        height: 55.h,
                        child: PrimaryTextButton(
                          appButtonSize: AppButtonSize.xxLarge,
                          onTap: () {
                            Navigator.pop(context);
                            onConfirm();
                          },
                          label: Text(
                            confirm_text,
                            style: context.typography.bodyLarge,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.errorForeground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                        ),
                        child: Text(
                          confirm_text,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
