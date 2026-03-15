import '../../../../index/index_main.dart';

class UpgradeQualifiedInvestorWidget extends StatelessWidget {
  final VoidCallback? onUpgrade;

  const UpgradeQualifiedInvestorWidget({super.key, this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(12.r),
        image: LocalStorageTheme().read() == "dark"
            ? null
            : const DecorationImage(
                image: AssetImage(Images.background_light),
                fit: BoxFit.fill,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 🔹 Title
          Text(
            "upgrade_to_qualified_investor".tr,
            style: context.typography.headerXLarge.copyWith(
              color: AppColors.brand_bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),

          /// 🔹 Description
          Text(
            "qualified_investor_description".tr,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),

          SizedBox(height: 20.h),

          /// 🔹 Action Button
          SizedBox(
            width: double.infinity,
            child: PrimaryTextButton(
              onTap: () {
                Get.toNamed(upgradetoprofessionalview);
              },
              trailing: (value) {
                return LocalStorage_language().read() != "ar"
                    ? const Icon(Icons.arrow_forward)
                    : const Icon(Icons.arrow_back);
              },
              label: Text(
                "activate_qualified_investor_benefits".tr,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaitingQualifiedInvestorWidget extends StatelessWidget {
  const WaitingQualifiedInvestorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
        image: LocalStorageTheme().read() == "dark"
            ? null
            : const DecorationImage(
                image: AssetImage(Images.background_light),
                fit: BoxFit.fill,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🟡 Title
          Text(
            "upgrade_request_under_review".tr,
            style: context.typography.headerXLarge.copyWith(
              color: AppColors.tag_icon_warning,
            ),
          ),
          SizedBox(height: 8.h),

          /// 🟡 Description
          Text(
            "upgrade_request_review_description".tr,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfessionalInvestorWidget extends StatelessWidget {
  const ProfessionalInvestorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(12.r),
        image: LocalStorageTheme().read() == "dark"
            ? null
            : const DecorationImage(
                image: AssetImage(Images.background_light),
                fit: BoxFit.fill,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🟢 Title
          Text(
            "qualified_investor".tr,
            style: context.typography.headerXLarge.copyWith(
              color: AppColors.successForeground,
            ),
          ),
          SizedBox(height: 8.h),

          /// 🟢 Description
          Text(
            "qualified_investor_approved_description".tr,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),
        ],
      ),
    );
  }
}
