import 'package:flutter/foundation.dart';
import 'package:thara/Domain/parameters/auth/register_param.dart';
import 'package:thara/Global/middleware/auth_middleware.dart';

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
