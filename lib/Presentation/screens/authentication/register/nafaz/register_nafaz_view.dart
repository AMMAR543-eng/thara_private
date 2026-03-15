import '../../../../../index/index_main.dart';

class RegisterNafazScreen extends StatelessWidget {
  const RegisterNafazScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NafazController>(
      init: NafazController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Title
            Text(
              "التوثيق من خلال نفاذ",
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.content_brand_secondary,
              ),
            ),
            SizedBox(height: 12.h),

            /// --- Subtitle
            Text(
              "اذهب إلى تطبيق نفاذ ووافق على الطلب من خلال اختيار الرقم الظاهر أدناه.",
              style: context.typography.bodyLarge.copyWith(
                color: AppColors.tertiary,
              ),
            ),

            /// --- Error Cases or Nafaz Box
            Expanded(
              child: Center(
                child: () {
                  if (controller.dob_error == true) {
                    return Text(
                      "invalid_birth_date".tr,
                      style: context.typography.headerLarge.copyWith(
                        color: AppColors.errorForeground,
                      ),
                      textAlign: TextAlign.center,
                    );
                  } else if (controller.address_individual_error == true) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "missing_individual_address".tr,
                          style: context.typography.headerLarge.copyWith(
                            color: AppColors.errorForeground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),

                        /// --- Logout Button
                        PrimaryTextButton(
                          label: Text(
                            "logout".tr,
                            style: context.typography.bodyLarge.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          onTap: () {
                            AuthService().logout(
                              voidCallBack: (status) {
                                Get.offAllNamed(loginScreen);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  } else if (controller.address_company_error == true) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "missing_company_address".tr,
                          style: context.typography.headerLarge.copyWith(
                            color: AppColors.errorForeground,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),

                        /// --- Logout Button
                        PrimaryTextButton(
                          label: Text(
                            "logout".tr,
                            style: context.typography.bodyLarge.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          onTap: () {
                            AuthService().logout(
                              voidCallBack: (status) {
                                Get.offAllNamed(loginScreen);
                              },
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    // Normal Nafaz code box
                    return SizedBox(
                      width: 150.w,
                      height: 150.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 150.w,
                            height: 150.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.background_Positive_Subtle,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.content_secondary.withOpacity(
                                  0.2,
                                ),
                                width: 1,
                              ),
                            ),
                            child: controller.validCode == false
                                ? const CircularProgressIndicator()
                                : Text(
                                    controller.nafazCode?.random ?? "--",
                                    style: context.typography.header4xLarge
                                        .copyWith(
                                          color: AppColors.black_color,
                                          fontSize: 100,
                                        ),
                                  ),
                          ),

                          Positioned(
                            top: -10.h,
                            right: -10.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.green_light,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                "نفاذ",
                                style: context.typography.bodyStrongLarge
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }(),
              ),
            ),

            SizedBox(height: 40.h),

            // /// --- Back Button
            // SizedBox(
            //   width: double.infinity,
            //   child: PrimaryTextButton(
            //     label: Text(
            //       "الخطوة السابقة",
            //       style: context.typography.bodyLarge.copyWith(
            //         color: AppColors.primary,
            //       ),
            //     ),
            //     customBackgroundColor: AppColors.white,
            //     customBorder: const BorderSide(
            //       color: AppColors.action_outline_normal,
            //     ),
            //     onTap: () => Get.back(),
            //   ),
            // ),
            SizedBox(height: 20.h),
          ],
        );
      },
    );
  }
}
