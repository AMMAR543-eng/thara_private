import '../../../../index/index_main.dart';

class SuccessAuthView extends StatefulWidget {
  const SuccessAuthView({super.key});

  @override
  State<SuccessAuthView> createState() => _SuccessAuthViewState();
}

class _SuccessAuthViewState extends State<SuccessAuthView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed(mainPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: GenericLanguageAppBar(title: "register_title".tr),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// 🔹 Background animation
              const GenericAnimationWidget(
                animation_file_name: Animations
                    .success, // 👈 نفس الانيميشن اللي مستخدم في forget pass
              ),

              /// 🔹 Overlay content
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "تم إنشاء الحساب بنجاح",
                    style: context.typography.headerLarge.copyWith(
                      color: AppColors.content_brand_secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "success_account".tr,
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
                        "تسجيل الدخول",
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
