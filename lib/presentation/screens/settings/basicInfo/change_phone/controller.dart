import '../../../../../index/index_main.dart';
import 'change_phone_bottomsheet.dart';
import 'verify_new_phone_bottomsheet.dart';

class ChangePhoneController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxInt secondsRemaining = 60.obs;
  final RxBool enableResend = false.obs;

  /// Start countdown timer
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

  /// Step 1: Open edit phone bottom sheet
  void openEditPhoneBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => EditPhoneBottomSheet(
        onConfirm: (newPhone) {
          _requestPhoneChange(context, newPhone);
        },
      ),
    );
  }

  /// Step 2: Request OTP for new phone
  void _requestPhoneChange(BuildContext context, String newPhone) {
    isLoading.value = true;
    SettingsService().changePhone(
      phone: newPhone,
      voidCallBack: (data) async {
        isLoading.value = false;
        if (data.customStatusCode == 200) {
          // openVerifyNewPhoneBottomSheet(context, newPhone);
          SettingsBasicInfoController controller =
              initUseCase(() => SettingsBasicInfoController());
          controller.getProfileData();
          controller.update();
          Loader.showSuccess(data.message ?? "");
        } else {
          Loader.showError("فشل إرسال رمز التحقق، حاول مرة أخرى");
        }
      },
    );
  }

  /// Step 3: Open verify OTP sheet
  void openVerifyNewPhoneBottomSheet(BuildContext context, String phone) {
    startResendTimer();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VerifyNewPhoneBottomSheet(phone: phone),
    );
  }

  /// Step 4: Verify OTP
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

  /// Step 5: Resend OTP
  void resendPhoneVerification(String phone) {
    if (!enableResend.value) return;

    startResendTimer();
    // Example API for resend:
    // SettingsService().resendPhoneOtp(
    //   phone: phone,
    //   voidCallBack: (_) {
    //     Loader.showSuccess("تم إرسال الرمز مرة أخرى");
    //   },
    // );
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
