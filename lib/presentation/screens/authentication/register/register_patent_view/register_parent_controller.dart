import 'package:get/get.dart';

class RegisterParentController extends GetxController {
  var currentStep = 0.obs;

  RegisterParentController({int initialStep = 0}) {
    currentStep.value = initialStep;
  }

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}
