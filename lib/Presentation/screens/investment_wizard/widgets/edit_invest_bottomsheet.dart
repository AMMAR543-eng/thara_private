import '../../../../index/index_main.dart';

void showInvestSettingsSheet(
  BuildContext context,
  InvestmentWizardEntity entity,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.45,
        minChildSize: 0.35,
        maxChildSize: 0.55,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔥 العنوان
                    Text(
                      "auto_invest_title".tr,
                      style: context.typography.headerLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🔥 وصف الحالة
                    Text(
                      "auto_invest_enabled_now".tr,
                      style: context.typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔥 زر تعديل الإعدادات
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: PrimaryTextButton(
                        appButtonSize: AppButtonSize.xxLarge,
                        customBackgroundColor: AppColors.primary_normal,
                        label: Text(
                          "edit_auto_invest_settings".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(
                            () => InvestmentWizardScreen(editData: entity),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    // 🔥 زر إيقاف الاستثمار
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: PrimaryTextButton(
                        appButtonSize: AppButtonSize.xxLarge,
                        customBackgroundColor: AppColors.errorForeground,
                        label: Text(
                          "stop_auto_invest".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          OpportunitiesService().cancelAutoInvestment(
                            voidCallBack: (data) {
                              DashboardController dashboard = initUseCase(
                                () => DashboardController(),
                              );
                              dashboard.getAutoInvestData();
                              dashboard.update();
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
