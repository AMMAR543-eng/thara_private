import '../../../../index/index_main.dart';

class BioMetricView extends StatelessWidget {
  final UserModel userModel;
  final AccountModel accountModel;

  const BioMetricView({
    super.key,
    required this.userModel,
    required this.accountModel,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: GetBuilder<BiometricLoginViewModel>(
          init: BiometricLoginViewModel(),
          builder: (controller) {
            return Stack(
              children: [
                /// 🔹 Gradient Background
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.onboardingBackground,
                  ),
                ),
                Column(
                  children: [
                    /// 🔹 Top Section
                    Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Image.asset(
                              Images.auth_face_pattern,
                              fit: BoxFit.contain,
                            ),
                          ),

                          Column(
                            children: [
                              SafeArea(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: SvgPicture.asset(
                                      IconsConstants.logo,
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Image.asset(
                                  Images.face_id,
                                  height: 160.h,
                                  width: 160.w,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// 🔹 Bottom Card
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 24.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// Title + Subtitle
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "biometric_title".tr,
                                      style: context.typography.headerXLarge
                                          .copyWith(
                                            color: AppColors
                                                .content_brand_secondary,
                                          ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "biometric_subtitle".tr,
                                      style: context.typography.bodyMedium
                                          .copyWith(
                                            color: AppColors.content_secondary,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              /// Not Now Button
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryTextButton(
                                  onTap: () {
                                    handleUserNavigation(
                                      account: accountModel,
                                      user: userModel,
                                    );
                                  },
                                  customBackgroundColor: AppColors.white,
                                  customBorder: BorderSide(
                                    color: AppColors.action_natural_normal,
                                    width: 0.5,
                                  ),
                                  label: Text(
                                    "biometric_skip".tr,
                                    style: context.typography.bodyLarge
                                        .copyWith(
                                          color:
                                              AppColors.action_natural_normal,
                                        ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 12.h),

                              /// Enable Face ID Button
                              PressAnimatedButton(
                                backgroundColor: AppColors.primary_normal,
                                borderRadius: BorderRadius.circular(10),
                                label: Text(
                                  "biometric_enable".tr,
                                  style: context.typography.bodyLarge.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                onTap: () {
                                  controller.checkFirstBiometricAuth();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
