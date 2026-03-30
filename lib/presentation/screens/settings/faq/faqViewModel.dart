import 'package:get/get.dart';
import '../../../../index/index_main.dart';

class FaqVieWModel extends GetxController {
  FaqsData? faqData;
  List<FaqCategory> orderedCategories = [];

  @override
  void onInit() {
    super.onInit();
    getFaqData();
  }

  void getFaqData() {
    SettingsService().getFaqData(
      voidCallBack: (FaqsData? data) {
        if (data == null || data.faqs == null) return;

        faqData = data;

        /// Sort keys numerically: '1', '2', '3', ...
        final sortedKeys = data.faqs!.keys.toList()
          ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));

        /// Arrange ordered categories
        orderedCategories = sortedKeys
            .map((key) => data.faqs![key])
            .whereType<FaqCategory>() // ensure non-null
            .toList();

        update();
      },
    );
  }
}
