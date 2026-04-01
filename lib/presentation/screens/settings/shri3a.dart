import 'package:thara/Global/Utils/pdf_viewer.dart';
import '../../../index/index_main.dart';

class IslamicShariaa extends StatelessWidget {
  const IslamicShariaa({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "sharia_compliance_title".tr),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Header
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      IconsConstants.islamic,
                      height: 70.h,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "sharia_committee_title".tr,
                      style: typography.headerLarge.copyWith(
                        color: AppColors.content_primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "sharia_committee_desc".tr,
                      textAlign: TextAlign.center,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),

              /// --- Bullet Points
              _buildBullet(context, "sharia_point1".tr),
              _buildBullet(context, "sharia_point2".tr),
              _buildBullet(context, "sharia_point3".tr),
              _buildBullet(context, "sharia_point4".tr),
              _buildBullet(context, "sharia_point5".tr),
              SizedBox(height: 30.h),

              /// --- Download Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: LocalStorageTheme().read() == "light"
                      ? AppColors.background_banner
                      : AppColors.content_secondary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(IconsConstants.pdf_file_icom),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        "sharia_certificate_title".tr,
                        style: typography.headerLarge.copyWith(
                          color: AppColors.brand_bold,
                        ),
                      ),
                    ),
                    Text(
                      "sharia_certificate_desc".tr,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.tertiary,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const GenericPdfViewerFromAsset(
                            assetPath: 'assets/sharia.pdf',
                            title: 'شهادة الإعتماد الشرعي',
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "download_certificate".tr,
                            style: typography.bodyMedium.copyWith(
                              color: AppColors.primary_normal,
                              fontWeight: FontWeight.w600,
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
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              /// --- Footer / Note
              Center(
                child: Text(
                  "sharia_footer_note".tr,
                  style: typography.bodySmall.copyWith(
                    color: AppColors.tertiary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Reusable Bullet Widget
  Widget _buildBullet(BuildContext context, String text) {
    final typography = context.typography;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "•",
            style: typography.headerLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              text,
              style: typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
