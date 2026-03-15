import 'package:flutter/foundation.dart';
import '../../../../index/index_main.dart';

class ForgetPasswordController extends GetxController {
  // Form Key
  final formForgetKey = GlobalKey<FormState>();
  final formResetKey = GlobalKey<FormState>();

  // Text Controllers
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? code;

  // Validation States
  bool validEmail = false;
  bool validId = false;
  bool validPassword = false;
  bool validConfirmPassword = false;

  // Password visibility
  bool showPassword = false;
  bool showPasswordConfirm = false;

  // Password Rules
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool noSpaces = true;

  // Computed
  bool get canSubmit => validEmail && validId;

  // ✅ Use this for reset password
  bool get canSubmitResetPass =>
      validPassword &&
      validConfirmPassword &&
      passwordController.text == confirmPasswordController.text;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final data = await Get.arguments;
    code = data["code"];
    update();
    print("code is $code");
  }

  /// Update email validation
  void updateEmailValidation(bool value) {
    validEmail = value;
    update();
  }

  void updateIdValidation(bool value) {
    validId = value;
    update();
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    showPasswordConfirm = !showPasswordConfirm;
    update();
  }

  void updatePasswordValidation(bool value) {
    validPassword = value;
    _checkPasswordRules(passwordController.text);
    update();
  }

  void updateConfirmPasswordValidation(String value) {
    validConfirmPassword = value == passwordController.text && value.isNotEmpty;
    update();
  }

  void _checkPasswordRules(String password) {
    hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    hasLowerCase = password.contains(RegExp(r'[a-z]'));
    hasNumber = password.contains(RegExp(r'[0-9]'));
    hasMinLength = password.length >= 8;
    noSpaces = !password.contains(' ');
  }

  /// ✅ Step 1 - Initial Reset (Send OTP)
  Future<bool?> initialResetPassword(
    String email,
    String nin,
    BuildContext context,
  ) async {
    await AuthService().initialResetPassword(
      email: email,
      nin: nin,
      voidCallBack: (data) {
        if (kDebugMode) {
          print("data is $data");

        }
        if (data.customStatusCode == 200) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) =>
                OtpBottomSheet(length: 4, page: OtpPages.forget, phone: email,is_email: true,),
          );
        }
        return data.customStatusCode == 200;
      },
    );
    return false;
  }

  /// ✅ Step 2 - Reset Password
  Future<void> resetPassword(
    String email,
    String nin,
    String code,
    String password,
    String passwordConfirm,
  ) async {
    await AuthService().resetPassword(
      email: email,
      nin: nin,
      code: code,
      password: password,
      passwordConfirm: passwordConfirm,
      voidCallBack: (data) {
        if (kDebugMode) {
          print("data is $data");
        }
        if (data.customStatusCode == 200) {
          Get.toNamed(resetCompleteScreen);
        }
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    idController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
