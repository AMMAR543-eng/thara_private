import '../../../../../index/index_main.dart';
import 'change_phone_bottomsheet.dart';
import 'verify_email_otp_bottomsheet.dart';
import 'verify_new_phone_bottomsheet.dart';

class ChangePhoneController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 60.obs;
  final RxBool enableResend = false.obs;

  String _emailOtpCode = '';
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

  // Step 1: Call API to send OTP to user's email, then show email OTP sheet
  void requestEmailOtp(BuildContext context, String userEmail) {
    _rootContext = context;
    isLoading.value = true;
    SettingsService().changePhoneRequestOtp(
      voidCallBack: (data) async {
        isLoading.value = false;
        if (data.customStatusCode == 200) {
          _openEmailOtpBottomSheet(userEmail);
        } else {
          Loader.showError(data.message ?? "فشل إرسال رمز التحقق، حاول مرة أخرى");
        }
      },
    );
  }

  void _openEmailOtpBottomSheet(String email) {
    startResendTimer();
    showModalBottomSheet(
      context: _rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VerifyEmailOtpForPhoneChangeBottomSheet(email: email),
    );
  }

  // Step 2: Email OTP entered -> close email sheet, open new phone input sheet
  void onEmailOtpVerified(BuildContext context, String code) {
    _emailOtpCode = code;
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 300), () {
      _openEditPhoneBottomSheet();
    });
  }

  // Step 3: User enters new phone -> call change_phone_number with phone + email OTP
  void _openEditPhoneBottomSheet() {
    showModalBottomSheet(
      context: _rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditPhoneBottomSheet(
        onConfirm: (newPhone) {
          _submitPhoneChange(newPhone);
        },
      ),
    );
  }

  void _submitPhoneChange(String newPhone) {
    isLoading.value = true;
    SettingsService().changePhoneSubmit(
      phone: newPhone,
      otp: _emailOtpCode,
      voidCallBack: (data) async {
        isLoading.value = false;
        if (data.customStatusCode == 200) {
          Future.delayed(const Duration(milliseconds: 300), () {
            _openVerifyNewPhoneBottomSheet(newPhone);
          });
        } else {
          Loader.showError(data.message ?? "فشل تغيير رقم الجوال، حاول مرة أخرى");
        }
      },
    );
  }

  // Step 4: Phone OTP sheet -> verify the OTP sent to the new phone
  void _openVerifyNewPhoneBottomSheet(String phone) {
    startResendTimer();
    showModalBottomSheet(
      context: _rootContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VerifyNewPhoneBottomSheet(phone: phone),
    );
  }

  void verifyNewPhoneApi(String phone, String code) {
    isLoading.value = true;
    SettingsService().verifyNewPhone(
      phone: phone,
      code: code,
      voidCallBack: (data) async {
        isLoading.value = false;
        Get.back();
        Loader.showSuccess("تم تأكيد رقم الجوال بنجاح");

        if (Get.isRegistered<SettingsBasicInfoController>()) {
          Get.find<SettingsBasicInfoController>().getProfileData();
        }
      },
    );
  }

  // Resend email OTP (step 1 retry)
  void resendEmailOtp() {
    if (!enableResend.value) return;
    startResendTimer();
    SettingsService().changePhoneRequestOtp(
      voidCallBack: (data) {
        Loader.showSuccess(data.message ?? "code_resent_success".tr);
      },
    );
  }

  // Resend phone OTP (step 4 retry)
  void resendPhoneVerification(String phone) {
    if (!enableResend.value) return;
    startResendTimer();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
