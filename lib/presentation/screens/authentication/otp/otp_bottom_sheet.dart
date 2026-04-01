import '../../../../index/index_main.dart';

class OtpBottomSheet extends StatelessWidget {
  final int length;
  final OtpPages page;
  final String phone;
  final bool? is_email;
  final bool? is_company;

  const OtpBottomSheet({
    super.key,
    this.length = 4,
    this.is_email = false,
    required this.page,
    required this.phone,
    this.is_company,
  });

  @override
  Widget build(BuildContext context) {
    // reuse existing controller if already created
    final controller = Get.isRegistered<OtpController>()
        ? Get.find<OtpController>()
        : Get.put(OtpController());

    final numberController = TextEditingController();

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Handle
              Container(
                width: 60.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                  color: AppColors.border_natural_normal,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              /// Title
              Text(
                "otp_enter_code".tr,
                style: context.typography.headerXLarge.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              /// Description
              Text(
                (page == OtpPages.register ||
                        page == OtpPages.registerIndi ||
                        is_email == true)
                    ? "otp_sent_email".tr
                    : "otp_sent_phone".tr,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              /// Phone/email shown
              Text(
                phone,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_primary,
                ),
                textAlign: TextAlign.center,
              ),

              /// OTP input
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    appContext: context,
                    controller: numberController,
                    length: page == OtpPages.forget ? 6 : length,
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.center,
                    autoDismissKeyboard: false,
                    autoFocus: true,
                    cursorColor: AppColors.primary,
                    enableActiveFill: true,
                    textStyle: context.typography.headerXLarge.copyWith(
                      color: AppColors.primary,
                    ),
                    onChanged: (value) {
                      final isValid = value.length ==
                          (page == OtpPages.forget ? 6 : length);
                      if (isValid) {
                        controller.setOtpValidation(isValid);

                        void clearInput() {
                          FocusScope.of(context).unfocus();
                          numberController.clear();
                        }

                        if (page == OtpPages.forget) {
                          Get.to(() => ResetPasswordScreen(code: value),
                              binding: Binding());
                          clearInput();
                        } else if (page == OtpPages.login) {
                          controller.verifyOtp(value, clearInput);
                        } else if (page == OtpPages.register ||
                            page == OtpPages.registerIndi) {
                          controller.registerVerifyOtp(
                              value, clearInput, is_company);
                        } else if (page == OtpPages.withdraw) {
                          // handle withdraw verifyOtp if you have ID
                        }
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50.h,
                      fieldWidth: 50.w,
                      borderWidth: 0.5,
                      activeColor: AppColors.primary,
                      fieldOuterPadding: EdgeInsets.only(left: 8.w),
                      selectedColor: AppColors.primary,
                      inactiveColor: AppColors.primary,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                  ),
                ),
              ),

              /// Resend line
              Obx(
                () => Text.rich(
                  TextSpan(
                    text: "otp_not_received".tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.tertiary,
                    ),
                    children: [
                      TextSpan(
                        text: controller.enableResend.value
                            ? "otp_resend_request".tr
                            : "otp_resend_in".trParams({
                                "seconds": controller.secondsRemaining.value
                                    .toString(),
                              }),
                        style: context.typography.bodyStrongMedium.copyWith(
                          color: controller.enableResend.value
                              ? AppColors.primary
                              : AppColors.action_natural_normal,
                          decoration: controller.enableResend.value
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.enableResend.value
                              ? () => controller.resend(page: page)
                              : null,
                      ),
                    ],
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
}
