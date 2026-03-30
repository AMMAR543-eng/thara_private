
import 'package:thara/index/index_main.dart';


class OnboardCheck extends GetxController {
  Future<bool> saveAlreadyOpen(bool isUpdate) {
    return StorageService().setData(Strings.force_update, isUpdate);
  }

  Future<bool> getOpen() async {
    return await StorageService().getData(Strings.force_update);
  }
}
