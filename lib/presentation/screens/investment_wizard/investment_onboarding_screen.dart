import 'package:thara/index/index_main.dart';

class InvestmentOnboardingScreen extends StatelessWidget {
  const InvestmentOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: BackButton(color: AppColors.content_primary),
        title: Text(
          "auto_invest_title_header".tr,
          style: context.typography.headerLarge.copyWith(
            color: AppColors.content_primary,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Subtitle
              Text(
                "auto_invest_subtitle".tr,
                style: context.typography.bodyLarge.copyWith(
                  color: AppColors.content_secondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              _buildFeature(
                context,
                title: "auto_invest_feature_simple".tr,
                description: "auto_invest_feature_simple_desc".tr,
              ),

              const SizedBox(height: 20),

              _buildFeature(
                context,
                title: "auto_invest_feature_control".tr,
                description: "auto_invest_feature_control_desc".tr,
              ),

              const SizedBox(height: 20),

              _buildFeature(
                context,
                title: "auto_invest_feature_tracking".tr,
                description: "auto_invest_feature_tracking_desc".tr,
              ),

              const SizedBox(height: 20),

              _buildFeature(
                context,
                title: "auto_invest_feature_flexibility".tr,
                description: "auto_invest_feature_flexibility_desc".tr,
              ),

              const SizedBox(height: 20),

              _buildFeature(
                context,
                title: "auto_invest_feature_free".tr,
                description: "auto_invest_feature_free_desc".tr,
              ),

              const SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  Get.to(
                    () => GenericPdfViewerFromAsset(
                      assetPath: 'assets/RiskStatement_AutomatedInvesting.pdf',
                      title: 'risk_level'.tr,
                    ),
                  );
                },
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "risk_level_consent".tr,
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.primary_normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SvgPicture.asset(
                      IconsConstants.download,
                      width: 20.w,
                      height: 20.h,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // CTA Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: PressAnimatedButton(
                  backgroundColor: AppColors.primary_normal,
                  borderRadius: BorderRadius.circular(12),
                  label: Text(
                    "activate_auto_invest".tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  onTap: () {
                    Get.to(() => const InvestmentWizardScreen());
                  },
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Icon(Icons.circle, size: 8, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.typography.bodyLarge.copyWith(
                  color: AppColors.content_primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
