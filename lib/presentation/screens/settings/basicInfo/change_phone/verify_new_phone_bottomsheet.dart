import '../../../../../index/index_main.dart';
import 'controller.dart';

class VerifyNewPhoneBottomSheet extends StatelessWidget {
  final String phone;

  const VerifyNewPhoneBottomSheet({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ChangePhoneController>()
        ? Get.find<ChangePhoneController>()
        : Get.put(ChangePhoneController());

    final otpController = TextEditingController();
    final RxBool validOtp = false.obs;
    final RxInt secondsRemaining = 60.obs;
    final RxBool enableResend = false.obs;

    ever(secondsRemaining, (value) {
      if (value == 0) enableResend.value = true;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });

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
              /// Handle bar
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
                "enter_otp_for_new_phone".tr,
                textAlign: TextAlign.center,
                style: context.typography.headerXLarge.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                "otp_sent_to_phone".tr,
                textAlign: TextAlign.center,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
              ),
              SizedBox(height: 8.h),

              Text(
                phone,
                textAlign: TextAlign.center,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_primary,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: AppTextField(
                    controller: otpController,
                    hintText: "000000",
                    keyboardType: TextInputType.number,
                    onValidationChanged: (value) {
                      validOtp.value = otpController.text.trim().isNotEmpty;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: Obx(() => PrimaryTextButton(
                  onTap: validOtp.value
                      ? () {
                          final code = otpController.text.trim();
                          if (code.isEmpty) return;
                          FocusScope.of(context).unfocus();
                          controller.verifyNewPhoneApi(phone, code);
                        }
                      : null,
                  appButtonSize: AppButtonSize.large,
                  label: Text(
                    "continue".tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ),

              /// Resend section
              Obx(
                () => Text.rich(
                  TextSpan(
                    text: "did_not_receive_code".tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.tertiary,
                    ),
                    children: [
                      TextSpan(
                        text: enableResend.value
                            ? "resend_code".tr
                            : "resend_in_seconds".trParams({
                                "seconds": secondsRemaining.value.toString(),
                              }),
                        style: context.typography.bodyStrongMedium.copyWith(
                          color: enableResend.value
                              ? AppColors.primary
                              : AppColors.action_natural_normal,
                          decoration: enableResend.value
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = enableResend.value
                              ? () {
                                  secondsRemaining.value = 60;
                                  enableResend.value = false;
                                  Timer.periodic(const Duration(seconds: 1),
                                      (timer) {
                                    if (secondsRemaining.value > 0) {
                                      secondsRemaining.value--;
                                    } else {
                                      timer.cancel();
                                      enableResend.value = true;
                                    }
                                  });
                                  controller.resendPhoneVerification(phone);
                                }
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
