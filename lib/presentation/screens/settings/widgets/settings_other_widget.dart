import 'package:thara/index/index_main.dart';

class SettingsOtherWidget extends StatelessWidget {
  const SettingsOtherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isGuest =
        LoginResponseModel().getTokenData()?.data?.accessToken == null;

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
            GetBuilder<AppLanguage>(
              init: AppLanguage(),
              builder: ((controller) {
                return SettingsItemWidget(
                  title: "language".tr,
                  icon: IconsConstants.langSettings,
                  onTap: () {
                    showLanguageBottomSheet(context, controller);
                  },
                );
              }),
            ),
            Divider(
              color: AppColors.grayMedium.withAlpha(128),
              endIndent: 20.h,
              indent: 20.h,
            ),
            SettingsItemWidget(
              title: "sharia_committee".tr,
              icon: IconsConstants.aboutSettings,
              onTap: () {
                Get.to(
                  () => const IslamicShariaa(),
                  binding: Binding(),
                  duration: const Duration(milliseconds: 0),
                );
              },
            ),
            _divider(),
            SettingsItemWidget(
              title: "about us".tr,
              icon: IconsConstants.aboutSettings,
              onTap: () {
                Get.to(
                  () => const AboutUsView(),
                  binding: Binding(),
                  duration: const Duration(milliseconds: 0),
                );
              },
            ),
            _divider(),
            SettingsItemWidget(
              title: "financial_reports".tr,
              icon: IconsConstants.questionsSetting,
              onTap: () {
                Get.to(
                  () => const FinanicalReportsView(),
                  binding: Binding(),
                  duration: const Duration(milliseconds: 0),
                );
              },
            ),
            _divider(),
            SettingsItemWidget(
              title: "faq".tr,
              icon: IconsConstants.questionsSetting,
              onTap: () {
                Get.to(
                  () => const FaqView(),
                  binding: Binding(),
                  duration: const Duration(milliseconds: 0),
                );
              },
            ),
            _divider(),
            SettingsItemWidget(
              title: "articles".tr,
              icon: IconsConstants.vlogSettings,
              onTap: () {
                Get.to(
                  () => const ArticlesView(),
                  duration: const Duration(milliseconds: 0),
                  binding: Binding(),
                );
              },
            ),
            _divider(),
            SettingsItemWidget(
              title: "terms_conditions".tr,
              icon: IconsConstants.termsSettings,
              onTap: () {
                Get.to(
                  () => const TermsConditions(),
                  binding: Binding(),
                  duration: const Duration(milliseconds: 0),
                );
              },
            ),
            if (!isGuest) ...[
              _divider(),
              SettingsItemWidget(
                title: "logout".tr,
                icon: IconsConstants.termsSettings,
                onTap: () => showLogoutDialog(context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(
        color: AppColors.grayMedium.withAlpha(128),
        endIndent: 20.h,
        indent: 20.h,
      );

  void showLogoutDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const LogoutDialog());
  }

  void showLanguageBottomSheet(BuildContext context, AppLanguage controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColors.white,
      builder: (_) {
        final currentLang = LocalStorage_language().read();

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'choose_language'.tr,
                  style: context.typography.font42Grey.copyWith(
                    color: AppColors.background_black,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text('arabic'.tr),
                  trailing: currentLang == 'ar'
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    if (currentLang != 'ar') {
                      controller.changeLanguage('ar');
                    }
                    Get.back();
                  },
                ),
                ListTile(
                  title: Text('english'.tr),
                  trailing: currentLang == 'en'
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    if (currentLang != 'en') {
                      controller.changeLanguage('en');
                    }
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
