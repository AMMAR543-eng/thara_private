import '../../../../index/index_main.dart';

class CheckGuestUser {
  final String? token = LoginResponseModel().getTokenData()?.data?.accessToken;

  void checkAuth(VoidCallback onpress) {
    if (token == null) {
      openGuestUserBottomSheet("login_first".tr);
    } else {
      onpress();
    }
  }

  void openGuestUserBottomSheet(String message) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          boxShadow: [
            BoxShadow(
              color: AppColors.border_natural_normal.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 📝 Message
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  message,
                  style: Get.context!.typography.bodyStrongLarge.copyWith(
                    color: AppColors.text_primary_paragraph,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.h),

              /// 🔘 Buttons Row
              Row(
                children: [
                  /// ❌ Cancel Button
                  Expanded(
                    child: SizedBox(
                      height: 55.h,
                      child: PrimaryTextButton(
                        onTap: () => Get.back(),
                        customBackgroundColor: AppColors.background_neutral_100,
                        appButtonSize: AppButtonSize.xxLarge,
                        label: Text(
                          "canceled".tr,
                          style: Get.context!.typography.bodyStrongLarge
                              .copyWith(
                                color: AppColors.textSecondaryParagraph,
                              ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  /// 🔐 Login Button
                  Expanded(
                    child: SizedBox(
                      height: 55.h,
                      child: PrimaryTextButton(
                        onTap: () {
                          Get.back();
                          Get.offAllNamed(loginScreen);
                        },
                        customBackgroundColor: AppColors.action_primary_normal,
                        appButtonSize: AppButtonSize.xxLarge,
                        label: Text(
                          "login".tr,
                          style: Get.context!.typography.bodyStrongLarge
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void openGuestUserDialog(String message) {
    Get.defaultDialog(
      title: "",
      contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
      middleText: message,
      middleTextStyle: Get.context!.typography.font42Grey.copyWith(
        color: AppColors.background_black,
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.offAllNamed(loginScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 60.w),
        ),
        child: Text(
          "login".tr,
          style: Get.context!.typography.font49Red.copyWith(
            color: AppColors.background_black,
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.grayLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 60.w),
        ),
        child: Text(
          "Cancel".tr,
          style: Get.context!.typography.font49Grey.copyWith(),
        ),
      ),
    );
  }
}
