import '../../index/index_main.dart';

void handleUserNavigation({
  required UserEntity user,
  required AccountModel account,
  bool? is_biometric,
  VoidCallback? onNoMatch, // ✅ Optional callback
}) {
  // 🛡️ 1. Check 2FA
  if (user.passTwoFactor == false) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OtpBottomSheet(
        length: 4,
        page: OtpPages.login,
        phone: user.phoneNumber ?? user.email ?? "",
        is_email: user.phoneNumber == null ? true : false,
      ),
    );
    return;
  }

  // 🔑 2. Check password update requirement
  if (user.needPassword == true) {
    Get.toNamed(updatePasswordScreen);
    return;
  }

  // 📋 3. Check registration stage
  final String? activeStep = account.registrationStage ?? "";
  final bool? nafath = account.nafathCompleted;

  // 🔑 2. Check password update requirement
  if (activeStep == "finished" && nafath == false) {
    Get.toNamed(loginNafazScreen);
    return;
  }

  switch (activeStep) {
    case "email_verification":
      showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => OtpBottomSheet(
          length: 4,
          page: OtpPages.register,
          phone: user.email ?? "",
          is_email: user.phoneNumber == null ? true : false,
        ),
      );
      return;

    case "basic_info":
      Get.offAll(() => const RegisterParentView(index: 0), binding: Binding());
      return;
    case "nafath":
      Get.offAll(() => const RegisterParentView(index: 1), binding: Binding());
      return;
    case "kyc":
      Get.offAll(() => const RegisterParentView(index: 2), binding: Binding());

      return;
    case "signing":
      Get.offAll(() => const RegisterParentView(index: 3), binding: Binding());

      return;
    case "under_review":
      Get.toNamed(underReview);
      return;

    default:
      Get.offAllNamed(mainPage);
  }
}
