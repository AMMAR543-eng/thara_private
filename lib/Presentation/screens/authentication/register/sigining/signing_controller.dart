import '../../../../../index/index_main.dart';

class SigningController extends GetxController {
  SingingDetailsEntity? singing;

  @override
  onInit() {
    super.onInit();
    singingAgreementApi();
  }

  singingAgreementApi() {
    RegisterService().singingAgreement(
      voidCallBack: (data) {
        singing = data;
        update();
      },
    );
  }

  singingWithSirar() {
    RegisterService().singingWithSirar(
      voidCallBack: (data) {
        if (data.customStatusCode == 200) {
          Get.offAndToNamed(successAuthView);
        }
      },
    );
  }
}
