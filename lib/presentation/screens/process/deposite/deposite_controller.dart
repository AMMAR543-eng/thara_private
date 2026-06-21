import 'package:get/get.dart';

import '../../../../index/index_main.dart';

class DepositeController extends GetxController {
  BaseEntity? baseEntity;

  @override
  onInit() {
    super.onInit();
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      getMeData();
    }
  }

  getMeData() {
    AuthService().me(
      voidCallBack: (data) {
        baseEntity = data;
        update();
      },
    );
  }
}
