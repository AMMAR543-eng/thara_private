import 'package:flutter/foundation.dart';
import '../../../../../index/index_main.dart';

class RegisterController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? typeConfirmed = AccountType.individual.name;

  bool showPassword = false;
  bool showConfirm = false;
  bool? check_terms = false;

  bool validPassword = false;
  bool validConfirm = false;
  bool validEmail = false;

  GenericListModel? selectedType;

  List<GenericListModel> listTypes = [];

  @override
  void onInit() {
    super.onInit();
    listTypes = [
      GenericListModel(id: 1, name_ar: 'فرد'.tr, name: 'individual'.tr),
      GenericListModel(id: 2, name_ar: 'شركة'.tr, name: 'company'.tr),
    ];
    selectedType = listTypes[0];

    /// --- Password listener
    passwordController.addListener(() {
      final text = passwordController.text;
      final hasUpper = RegExp(r'[A-Z]').hasMatch(text);
      final hasLower = RegExp(r'[a-z]').hasMatch(text);
      final hasNumber = RegExp(r'[0-9]').hasMatch(text);
      final hasSpecial = RegExp(
        r'[!@#\$%^&*(),.?":{}|<>]',
      ).hasMatch(text); // 👈 new rule
      final hasMinLen = text.length >= 8;
      final noSpaces = !text.contains(' ');

      validPassword =
          hasUpper &&
          hasLower &&
          hasNumber &&
          hasSpecial &&
          hasMinLen &&
          noSpaces;
      update(['auth_button']);
    });

    /// --- Confirm password listener
    confirmPasswordController.addListener(() {
      validConfirm =
          confirmPasswordController.text == passwordController.text &&
          confirmPasswordController.text.isNotEmpty;
      update(['auth_button']);
    });
  }

  void onTypeSelected(GenericListModel? type) {
    selectedType = type;
    typeConfirmed = type?.id == 1
        ? AccountType.individual.name
        : AccountType.company.name;
    update(['auth_button']);
    update();
  }

  void setValidation({bool? email, bool? password, bool? confirm}) {
    if (email != null) validEmail = email;
    if (password != null) validPassword = password;
    if (confirm != null) validConfirm = confirm;
    update(['auth_button']);
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    update();
  }

  void toggleConfirm() {
    showConfirm = !showConfirm;
    update();
  }

  void updatePasswordValidation(bool isValid) {
    validPassword = isValid;
    update(['auth_button']);
  }

  void updateConfirmPasswordValidation(bool isValid) {
    validConfirm = isValid;
    update(['auth_button']);
  }

  void onSubmit(BuildContext context) {
    if (registerFormKey.currentState?.validate() ?? false) {
      registerEmailApi(
        SignUpParam(
          email: emailController.text,
          password: passwordController.text,
          passwordConfirm: confirmPasswordController.text,
          type: typeConfirmed!,
        ),
        () {
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          selectedType = null;
          update();
        },
        context,
      );
    }
  }

  void registerEmailApi(
    SignUpParam param,
    void Function()? clear,
    BuildContext context,
  ) {
    RegisterService().registerEmail(
      param: param,
      voidCallBack: (data) async {

        if (data.accessToken != null && data.accessToken!.isNotEmpty) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => OtpBottomSheet(
              length: 4,
              page: OtpPages.register,
              is_company: selectedType?.id == 1 ? false : true,
              phone: emailController.text,
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
