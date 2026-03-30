import '../../index/index_main.dart';

class Loader {
  /// 🔹 Show loading indicator
  static show() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 3000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 100
      ..radius = 10
      ..lineWidth = 10
      ..maskColor = Colors.grey
      ..indicatorColor = AppColors.primary
      ..userInteractions = false
      ..dismissOnTap = false
      ..backgroundColor = Colors.transparent
      ..textColor = AppColors.primary
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.chasingDots;
    EasyLoading.show(status: '');
  }

  /// 🔹 Dismiss loading
  static dismiss() {
    EasyLoading.dismiss();
  }

  /// 🔹 Info message
  static showInfo(String txt) {
    EasyLoading.dismiss();
    Get.snackbar(
      "info".tr,
      txt,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      borderRadius: 20,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.up,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  /// 🔹 Success message
  static showSuccess(String txt, {SnackPosition? snackPosition}) {
    EasyLoading.dismiss();
    Get.snackbar(
      "success".tr,
      txt,
      icon: Icon(Icons.done, color: AppColors.white),
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: AppColors.primary,
      borderRadius: 20,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  /// 🔹 Error message
  static void showError(String txt) {
    EasyLoading.dismiss();

    Future.delayed(const Duration(milliseconds: 0), () {
      final overlay = Overlay.of(Get.context!);

      final overlayEntry = OverlayEntry(
        builder: (context) => AnimatedErrorMessage(txt: txt),
      );

      overlay.insert(overlayEntry);

      Future.delayed(const Duration(seconds: 3), () {
        overlayEntry.remove();
      });
    });
  }
}
