import 'package:thara/index/index_main.dart';

class SettingsInfoWidget extends StatelessWidget {
  const SettingsInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.grayMedium.withAlpha(128),
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            SettingsItemWidget(
              title: "personal_info".tr,
              icon: IconsConstants.userSettings,
              onTap: () => Get.toNamed(settingsBasicInfoView),
            ),
            Divider(
              color: AppColors.grayMedium.withAlpha(128),
              endIndent: 20.h,
              indent: 20.h,
            ),
            // SettingsItemWidget(
            //   title: "kyc_form".tr,
            //   icon: IconsConstants.formSetting,
            //   onTap: () => Get.toNamed(settingsKYCInfoView),
            // ),
            // Divider(
            //   color: AppColors.grayMedium.withAlpha(128),
            //   endIndent: 20.h,
            //   indent: 20.h,
            // ),
            SettingsItemWidget(
              title: "bank_info".tr,
              icon: IconsConstants.infoSettings,
              onTap: () => Get.toNamed(settingsBankInfoView),
            ),
          ],
        ),
      ),
    );
  }
}
