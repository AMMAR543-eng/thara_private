import 'package:thara/Presentation/screens/settings/basicInfo/change_email/verify_new_email_view.dart';

import '../../../../../index/index_main.dart';
import 'change_email_bottomsheet.dart';

class ChangeEmailController extends GetxController {
  /// Text controller for email input
  final TextEditingController emailController = TextEditingController();

  /// Reactive states
  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 60.obs;
  final RxBool enableResend = false.obs;
  final RxBool validOtp = false.obs;

  /// Initialize resend timer
  void startResendTimer() {
    secondsRemaining.value = 60;
    enableResend.value = false;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
        timer.cancel();
      }
    });
  }

  /// --- Step 1: Open bottom sheet to enter new email
  void openEditEmailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditEmailBottomSheet(
        onConfirm: (newEmail) {
          _requestEmailChange(context, newEmail);
        },
      ),
    );
  }

  /// --- Step 2: Call API to request OTP to new email
  void _requestEmailChange(BuildContext context, String newEmail) {
    isLoading.value = true;

    SettingsService().changeEmail(
      email: newEmail,
      voidCallBack: (data) async {
        isLoading.value = false;
        if (data.customStatusCode == 200) {
          // ✅ Open verify sheet
          openVerifyNewEmailBottomSheet(context, newEmail);
        } else {
          Loader.showError("فشل إرسال رمز التحقق، حاول مرة أخرى");
        }
      },
    );
  }

  /// --- Step 3: Open OTP Verification Sheet
  void openVerifyNewEmailBottomSheet(BuildContext context, String email) {
    startResendTimer();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VerifyNewEmailBottomSheet(email: email),
    );
  }

  /// --- Step 4: Verify the new email OTP
  void verifyNewEmailApi(String email, String code) {
    isLoading.value = true;

    SettingsService().verifyNewEmail(
      email: email,
      code: code,
      voidCallBack: (data) async {
        isLoading.value = false;
        Get.back(); // close bottom sheet
        Loader.showSuccess("تم تأكيد البريد الإلكتروني بنجاح");

        /// refresh user data after success
        if (Get.isRegistered<SettingsBasicInfoController>()) {
          Get.find<SettingsBasicInfoController>().getProfileData();
        }
      },
    );
  }

  /// --- Step 5: Resend OTP email
  void resendEmailVerification(String email) {
    if (!enableResend.value) return;

    startResendTimer();
    // SettingsService().resendEmailOtp(
    //   email: email,
    //   voidCallBack: (_) {
    //     Loader.showSuccess("تم إرسال الرمز مرة أخرى");
    //   },
    // );
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
