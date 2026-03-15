import 'package:thara/index/index_main.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "account_settings".tr),
      body: GetBuilder<SettingsBasicInfoController>(
        init: SettingsBasicInfoController(),
        builder: (controller) {
          final user = controller.userInfoModel?.personalInfo;
          final account = controller.account;

          // 🔹 Shimmer while loading
          if (user == null || account == null) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: InfoListShimmerWidget(),
            );
          }

          // 🔹 Main content
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- Profile Header
                LoginResponseModel().getTokenData()?.data?.accessToken == null
                    ? const SizedBox()
                    : Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 130.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                              color: AppColors
                                  .grayLight, // optional background
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              // 👈 THIS is key
                              child: _getProfileImage(controller),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        controller
                            .userInfoModel
                            ?.personalInfo
                            ?.fullNameAr ??
                            "",
                        style: context.typography.headerXLarge.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                      Text(
                        controller.profileData?.account?.id ?? "",
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// --- Verified / Waiting Badge
                if (controller.showVerifiedBadge)
                  Center(
                    child: _StatusBadge(
                      label: controller.verifiedBadgeLabel,
                      icon: IconsConstants.info_icon,
                      color: controller.verifiedBadgeColor,
                      isWaiting: controller.isWaitingProfessional,
                    ),
                  ),
                SizedBox(height: 30.h),

                /// --- Account Details
                _AccountDetailItem(
                  title: "investment_account_status".tr,
                  value: controller.investingStatusLabel,
                ),
                _AccountDetailItem(
                  title: "account_type".tr,
                  value: controller.accountTypeLabel,
                ),
                _AccountDetailItem(
                  title: "loan_account_status".tr,
                  value: controller.borrowingStatusLabel,
                ),

                SizedBox(height: 40.h),

                /// --- Upgrade to Professional Button
                SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: PrimaryTextButton(
                    appButtonSize: AppButtonSize.xlarge,
                    label: Text(
                      controller.isWaitingProfessional
                          ? "upgrade_request_pending".tr
                          : controller.isProfessionalInvestor
                          ? "already_professional_investor".tr
                          : "upgrade_to_professional_investor".tr,
                      style: context.typography.bodyLarge.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    onTap: !controller.canUpgradeToProfessional
                        ? null
                        : () => Get.toNamed(upgradetoprofessionalview),
                    leading: (value) {
                      return SvgPicture.asset(IconsConstants.upgrade_account);
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                /// --- Disable Account Button
                TextButton(
                  onPressed: () => controller.deleteMyProfileApi(context),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.errorForeground,
                    side: const BorderSide(color: AppColors.errorForeground),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "disable_account".tr,
                      style: context.typography.bodyStrongLarge.copyWith(
                        color: AppColors.errorForeground,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  CachedNetworkImage _getProfileImage(SettingsBasicInfoController controller) {
    final photoUrl = controller.profileData?.account?.profilePhoto?.url;

    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: photoUrl,
        fit: BoxFit.cover,
        width: double.infinity.w,
        height: double.infinity.h,
      );
    }

    final altPhoto = controller.userInfoModel?.account?.profilePhoto?.url;
    if (altPhoto != null && altPhoto.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: altPhoto,
        fit: BoxFit.cover,
        width: double.infinity.w,
        height: double.infinity.h,
      );
    }

    return CachedNetworkImage(
      imageUrl: Strings.placeholder_image,
      fit: BoxFit.contain,
      width: double.infinity.w,
      height: double.infinity.h,
    );
  }

}


class _StatusBadge extends StatelessWidget {
  final String label;
  final String icon;
  final Color color;
  final bool isWaiting;

  const _StatusBadge({
    required this.label,
    required this.icon,
    required this.color,
    this.isWaiting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, height: 24, width: 24, color: AppColors.white),
          SizedBox(width: 6.w),
          Text(
            label,
            style: context.typography.bodyStrongLarge.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountDetailItem extends StatelessWidget {
  final String title;
  final String value;

  const _AccountDetailItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
            typography.bodyStrongLarge.copyWith(color: AppColors.primary),
          ),
          Text(
            value,
            style: typography.bodyMedium
                .copyWith(color: AppColors.content_secondary),
          ),
        ],
      ),
    );
  }
}
