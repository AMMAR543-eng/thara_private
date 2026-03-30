
import '../../../../index/index_main.dart';

class UpdatePasswordController extends GetxController {
  updatePassword({required SignUpParam param}) {
    RegisterService().updatePassword(
      param: param,
      voidCallBack: (data) {
        handleUserNavigation(
          user: data.user ??  UserEntity(),
          account: data.account ?? AccountModel(),
        );
      },
    );
  }
}
