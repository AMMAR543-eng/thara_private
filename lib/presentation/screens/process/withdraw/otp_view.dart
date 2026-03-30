import '../../../../index/index_main.dart';

class OtpView extends StatelessWidget {
  final int length;
  final OtpPages page;
  final String phone;
  final bool? isEmail;
  final bool? isCompany;
  final String? withdrawId; // ✅ Added for withdraw use
  final String? title;
  final String? desc;

  const OtpView({
    super.key,
    this.length = 4,
    required this.page,
    required this.phone,
    this.isEmail = false,
    this.isCompany,
    this.withdrawId,
    this.title,
    this.desc,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ reuse existing controller if already created
    final controller = Get.isRegistered<OtpController>()
        ? Get.find<OtpController>()
        : Get.put(OtpController());

    final numberController = TextEditingController();

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
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
                title ?? "otp_enter_code".tr,
                style: context.typography.headerXLarge.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              /// Description
              Text(
                desc ??
                    ((page == OtpPages.register ||
                        page == OtpPages.registerIndi ||
                        isEmail == true)
                        ? "otp_sent_email".tr
                        : "otp_sent_phone".tr),
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              /// Phone or email
              Text(
                phone,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_primary,
                ),
                textAlign: TextAlign.center,
              ),

              /// OTP Input
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
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
                      color: AppColors.textDefault,
                    ),
                    onChanged: (value) {
                      final isValid =
                          value.length == (page == OtpPages.forget ? 6 : length);
                      if (isValid) {
                        controller.setOtpValidation(isValid);

                        void clearInput() {
                          FocusScope.of(context).unfocus();
                          numberController.clear();
                        }

                        // ✅ Flow handling for each page
                        if (page == OtpPages.forget) {
                          Get.to(() => ResetPasswordScreen(code: value),
                              binding: Binding());
                          clearInput();
                        } else if (page == OtpPages.login) {
                          controller.verifyOtp(value, clearInput);
                        } else if (page == OtpPages.register ||
                            page == OtpPages.registerIndi) {
                          controller.registerVerifyOtp(
                              value, clearInput, isCompany);
                        } else if (page == OtpPages.withdraw) {
                          controller.verifyWithdrawOtp(
                            withdrawId ?? '',
                            value,
                            clearInput,
                          );
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
                      activeFillColor: AppColors.white,
                      selectedFillColor: AppColors.white,
                      inactiveFillColor: AppColors.white,
                    ),
                  ),
                ),
              ),

              /// Resend Section
              Obx(
                    () => Text.rich(
                  TextSpan(
                    text: "${"otp_not_received".tr} ",
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
                              ? () => controller.resend(
                            page: page,
                            withdrawId: withdrawId,
                          )
                              : null,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 24.h),

              /// ✅ Confirm Button
              SizedBox(
                height: 50.h,
                width: ScreenUtil().screenWidth,
                child: PrimaryTextButton(
                  onTap: () {
                    final otp = numberController.text;
                    FocusScope.of(context).unfocus();

                    if (page == OtpPages.withdraw) {
                      controller.verifyWithdrawOtp(
                        withdrawId ?? '',
                        otp,
                            () => Get.back(),
                      );
                    } else if (page == OtpPages.login) {
                      controller.verifyOtp(otp, () => Get.back());
                    } else {
                      controller.setOtpValidation(otp.length == length);
                    }
                  },
                  label: Text(
                    "verify_code".tr,
                    style: context.typography.bodyStrongLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  appButtonSize: AppButtonSize.xxLarge,
                  customBackgroundColor: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
