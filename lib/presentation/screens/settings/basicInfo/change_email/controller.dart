import 'package:thara/Presentation/screens/settings/basicInfo/change_email/verify_new_email_view.dart';
import 'package:thara/Presentation/screens/settings/basicInfo/change_email/verify_phone_otp_bottomsheet.dart';

import '../../../../../index/index_main.dart';
import 'change_email_bottomsheet.dart';

class ChangeEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 60.obs;
  final RxBool enableResend = false.obs;
  final RxBool validOtp = false.obs;

  String _phoneOtpCode = '';
  late BuildContext _rootContext;

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

  // Step 1: Call request_change_email_otp -> sends OTP to phone
  void requestPhoneOtp(BuildContext context, String userPhone) {
    _rootContext = context;
    isLoading.value = true;
    SettingsService().changeEmailRequestOtp(
      voidCallBack: (data) async {
        isLoading.value = false;
        if (data.customStatusCode == 200) {
          _openPhoneOtpBottomSheet(userPhone);
        } else {
          Loader.showError(data.message ?? "فشل إرسال رمز التحقق، حاول مرة أخرى");
        }
      },
    );
  }

  void _openPhoneOtpBottomSheet(String phone) {
    startResendTimer();
    showModalBottomSheet(
      context: _rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VerifyPhoneOtpForEmailChangeBottomSheet(phone: phone),
    );
  }

  // Step 2: Phone OTP entered -> close sheet, open email input
  void onPhoneOtpVerified(BuildContext context, String code) {
    _phoneOtpCode = code;
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 300), () {
      _openEditEmailBottomSheet();
    });
  }

  // Step 3: User enters new email -> call request_change_email with email + phone OTP
  void _openEditEmailBottomSheet() {
    showModalBottomSheet(
      context: _rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditEmailBottomSheet(
        onConfirm: (newEmail) {
          _submitEmailChange(newEmail);
        },
      ),
    );
  }

  void _submitEmailChange(String newEmail) {
    isLoading.value = true;
    SettingsService().changeEmailSubmit(
      email: newEmail,
      otp: _phoneOtpCode,
      voidCallBack: (data) async {
        isLoading.value = false;
        if (data.customStatusCode == 200) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _openVerifyNewEmailBottomSheet(newEmail);
          });
        } else {
          Loader.showError(data.message ?? "فشل تغيير البريد الإلكتروني، حاول مرة أخرى");
        }
      },
    );
  }

  // Step 4: Email OTP sheet -> verify the OTP sent to the new email
  void _openVerifyNewEmailBottomSheet(String email) {
    startResendTimer();
    showModalBottomSheet(
      context: _rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VerifyNewEmailBottomSheet(email: email),
    );
  }

  void verifyNewEmailApi(String email, String code) {
    isLoading.value = true;
    SettingsService().verifyNewEmail(
      email: email,
      code: code,
      voidCallBack: (data) async {
        isLoading.value = false;
        Get.back();
        Loader.showSuccess("تم تأكيد البريد الإلكتروني بنجاح");

        if (Get.isRegistered<SettingsBasicInfoController>()) {
          Get.find<SettingsBasicInfoController>().getProfileData();
        }
      },
    );
  }

  // Resend phone OTP (step 1 retry)
  void resendPhoneOtp() {
    if (!enableResend.value) return;
    startResendTimer();
    SettingsService().changeEmailRequestOtp(
      voidCallBack: (data) {
        Loader.showSuccess(data.message ?? "code_resent_success".tr);
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
