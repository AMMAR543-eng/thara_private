import 'package:thara/index/index_main.dart';

class LoginController extends GetxController {
  final formLoginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool validEmail = false;
  bool validPassword = false;

  @override
  void onInit() {
    super.onInit();
    // LoginResponseModel().deleteTokenLocal();
    // const AccountModel().deleteAccountLocal();
    //  UserModel().deleteUserLocal();
    // BioUserModel.deleteBioLocal();

    if(UserModel().getUserData()?.email != null &&
        BioUserModel.getBioData()?.isBiometric == true){
      checkBiometric();
    }
  }

  checkBiometric() {
    final biometricVm = Get.put(BiometricLoginViewModel());
    biometricVm.checkBiometricAuth();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    // super.onClose();
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  void updateEmailValidation(bool isValid) {
    validEmail = isValid;
    update();
  }

  void updatePasswordValidation(bool isValid) {
    validPassword = isValid;
    update();
  }

  bool get canLogin => validEmail && validPassword;

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onForgotPassword() {
    Get.toNamed(forgetPasswordScreen);
  }

  void onCreateAccount() {
    Get.offAllNamed(register);
  }

  void onLogin(BuildContext context) {
    if (formLoginKey.currentState?.validate() ?? false) {
      login(
        emailController.text,
        passwordController.text,
        context,
        clearFields,
      );
    }
  }

  login(
    String email,
    String password,
    BuildContext context,
    void Function()? clear,
  ) {
    AuthService().login(
      params: LoginParams(email: email, password: password),
      voidCallBack: (loginModel) {

        String? token = loginModel.data?.accessToken;

        if (token != null && token.isNotEmpty) {
          handleUserNavigation(
            account: loginModel.account ?? const AccountModel(),
            user: loginModel.user ?? UserModel(),
          );
        }
      },
    );
  }
}
