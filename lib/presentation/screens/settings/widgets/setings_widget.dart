import 'package:thara/index/index_main.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

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
              title: "manage_notifications".tr,
              icon: IconsConstants.notificationSettings,
              onTap: () => Get.toNamed(settingsNotificationView),
            ),
            Divider(
              color: AppColors.grayMedium.withAlpha(128),
              endIndent: 20.h,
              indent: 20.h,
            ),

            SettingsItemWidget(
              title: "change_password_pin".tr,
              icon: IconsConstants.passSettings,
              onTap: () => Get.toNamed(settingsChangePassView),
            ),
          ],
        ),
      ),
    );
  }


}
