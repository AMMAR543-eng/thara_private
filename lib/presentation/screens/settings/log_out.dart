import '../../../../index/index_main.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// --- Icon
            Container(
              padding: EdgeInsets.all(18.w),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child:  Icon(
                Icons.logout_rounded,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            SizedBox(height: 20.h),

            /// --- Title
            Text(
              "logout_title".tr,
              textAlign: TextAlign.center,
              style: typography.headerLarge.copyWith(
                color: AppColors.content_primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),

            /// --- Description
            Text(
              "logout_description".tr,
              textAlign: TextAlign.center,
              style: typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
                height: 1.5,
              ),
            ),
            SizedBox(height: 30.h),

            /// --- Buttons
            Row(
              children: [
                /// Cancel Button
                Expanded(
                  child: PrimaryTextButton(
                    appButtonSize: AppButtonSize.large,
                    customBackgroundColor: AppColors.white,
                    customBorder: const BorderSide(
                      color: AppColors.border_natural_normal,
                      width: 1,
                    ),
                    onTap: () => Navigator.pop(context),
                    label: Text(
                      "cancel".tr,
                      style: typography.bodyLarge.copyWith(
                        color: AppColors.content_primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                /// Confirm Logout Button
                Expanded(
                  child: PrimaryTextButton(
                    appButtonSize: AppButtonSize.large,
                    customBackgroundColor: AppColors.primary,
                    onTap: () {
                      AuthService().logout(
                        voidCallBack: (status) {
                          LoginResponseModel().deleteTokenLocal();
                          const AccountModel().deleteAccountLocal();
                          UserModel().deleteUserLocal();
                          Get.offAllNamed(loginScreen);
                          Loader.showSuccess("logout_success".tr);
                        },
                      );
                    },
                    label: Text(
                      "confirm_logout".tr,
                      style: typography.bodyLarge.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
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
