import 'package:get/get.dart';
import 'package:thara/Presentation/parentControllers/settings_service.dart';
import '../../../../index/index_main.dart';

class FinancialReportsVieWModel extends GetxController {
  FinancialStatementsData? finaniclaData;

  @override
  void onInit() {
    getFinancialReportsData();
    super.onInit();
  }

  void getFinancialReportsData() {
    SettingsService().getFinancialStatementsData(
      voidCallBack: (data) {
        finaniclaData = data;

        update();
      },
    );
  }
}
