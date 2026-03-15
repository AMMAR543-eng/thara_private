import '../../../../index/index_main.dart';

class UnderReview extends StatefulWidget {
  const UnderReview({super.key});

  @override
  State<UnderReview> createState() => _UnderReviewState();
}

class _UnderReviewState extends State<UnderReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "مراجعة الحساب".tr,
          style: context.typography.headerXLarge.copyWith(
            color: AppColors.content_brand_secondary,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 🔹 Logo
            const Center(heightFactor: 1.5, child: LogoWidget()),
            SizedBox(height: 40.h),

            /// 🔹 محتوى النص
            Expanded(
              child: Center(
                child: Text(
                  "حسابك تحت المراجعة، سيتم إشعارك عند الانتهاء.".tr,
                  style: context.typography.bodyLarge.copyWith(
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            /// 🔹 زر تسجيل الخروج
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: PressAnimatedButton(
                backgroundColor: AppColors.primary_normal,
                disabledColor: AppColors.buttonDisabledColor,
                borderRadius: BorderRadius.circular(10.r),
                label: Text(
                  "تسجيل الخروج".tr,
                  style: context.typography.bodyLarge.copyWith(
                    color: AppColors.white,
                  ),
                ),
                onTap: () {
                  Get.offAllNamed(loginScreen);
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
