import '../../../../../index/index_main.dart';

class RegisterParentView extends StatelessWidget {
  final int index;
  final bool? isCompany;

  const RegisterParentView({super.key, required this.index, this.isCompany});

  @override
  Widget build(BuildContext context) {
    final parentController = Get.put(
      RegisterParentController(initialStep: index),
      permanent: false,
      tag: "parent_$index", // 👈 عشان يفرق بين الاستدعاءات
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: GenericLanguageAppBar(title: "register_title".tr),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Stepper
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                child: HorizontalStepper(
                  totalSteps: 4,
                  currentStep: parentController.currentStep.value,
                  activeColor: AppColors.brand_bold,
                  inactiveColor: AppColors.interaction_Neutral_Subtle_Normal,
                  circleSize: 30,
                ),
              ),
              SizedBox(height: 12.h),

              /// --- Step Content (dynamic)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: _buildStepContent(
                    parentController.currentStep.value,
                    isCompany,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Switch between child screens
  Widget _buildStepContent(int step, bool? isCompany) {
    switch (step) {
      case 0:
        return RegisterInfoScreen(isCompany: isCompany); // Step 1
      case 1:
        return const RegisterNafazScreen(); // Step 2
      case 2:
        return const RegisterKYCScreen(); // Step 3
      case 3:
        return const RegisterSigningScreen(); // Step 4
      default:
        return const SizedBox.shrink();
    }
  }
}
