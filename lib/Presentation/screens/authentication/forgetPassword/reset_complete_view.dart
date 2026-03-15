import '../../../../index/index_main.dart';

class ResetCompletedScreen extends StatelessWidget {
  const ResetCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const GenericLanguageAppBar(title: "إستعادة كلمة المرور"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Background animation
              const GenericAnimationWidget(
                animation_file_name: Animations.LOCK,
              ),

              /// Centered overlay content
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "تم تغيير كلمة المرور بنجاح",
                    style: context.typography.headerLarge.copyWith(
                      color: AppColors.content_brand_secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "لقد تم تغيير كلمة المرور بنجاح، يمكنك الآن استخدام كلمة المرور الجديدة للدخول إلى حسابك.",
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100.h),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryTextButton(
                      label: Text(
                        "العودة لصفحة تسجيل الدخول",
                        style: context.typography.bodyLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      onTap: () {
                        Get.offAllNamed(loginScreen);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
