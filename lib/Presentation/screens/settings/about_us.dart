import '../../../index/index_main.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "about_thara_title".tr),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// --- Logo Header
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      IconsConstants.logo,
                      height: 80.h,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "thara_company_name".tr,
                      style: typography.headerLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "thara_vision_summary".tr,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),

              /// --- Divider Line
              Divider(color: AppColors.border_natural_normal, thickness: 0.8),
              SizedBox(height: 24.h),

              /// --- Title: About Thara
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "about_us".tr,
                  style: typography.headerMedium.copyWith(
                    color: AppColors.content_primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                "about_us_description".tr,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                  height: 1.7,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30.h),

              /// --- Title: Vision
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "our_vision".tr,
                  style: typography.headerMedium.copyWith(
                    color: AppColors.content_primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                "vision_description".tr,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                  height: 1.7,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30.h),

              /// --- Title: Mission
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "our_mission".tr,
                  style: typography.headerMedium.copyWith(
                    color: AppColors.content_primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                "mission_description".tr,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                  height: 1.7,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 40.h),

              /// --- Contact Info Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.background_neutral_surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "contact_us".tr,
                      style: typography.headerMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "contact_info".tr,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              /// --- Footer
              Text(
                "© ${DateTime.now().year} ${"thara_company_name".tr}. ${"all_rights_reserved".tr}",
                style: typography.bodySmall.copyWith(color: AppColors.tertiary),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
