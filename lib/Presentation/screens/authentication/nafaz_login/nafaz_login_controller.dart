import 'dart:async';
import 'package:thara/Global/middleware/auth_middleware.dart';
import '../../../../../index/index_main.dart';

class NafazLoginController extends GetxController {
  NafathCodeEntity? nafazCode;
  bool validCode = false;
  Timer? _statusTimer;
  bool? dob_error;
  bool? address_individual_error;
  bool? address_company_error;

  @override
  void onInit() {
    nafathGetCodeApi();
    super.onInit();
  }

  @override
  void onClose() {
    _statusTimer?.cancel();
    super.onClose();
  }

  void nafathGetCodeApi() {
    RegisterService().nafathGetCode(
      isLogin: true,
      voidCallBack: (data) {
        nafazCode = data;
        validCode = true;
        startStatusPolling();
        update();
      },
    );
  }

  void nafathCheckStatusApi() {
    RegisterService().nafathCheckStatus(
      isLogin: true,
      voidCallBack: (data) async {
        final status = data.data?.status;
        bool nafathCompleted = data.account?.nafathCompleted ?? false;
        String? yaqeenProblem = data.account?.yaqeenProblem;

        if (data.data?.completed == true &&
            status == "COMPLETED" &&
            nafathCompleted == true &&
            yaqeenProblem == null) {
          _statusTimer?.cancel();

          UserModel? userData = UserModel().getUserData();
          if (userData?.email != null &&
              BioUserModel.getBioData()?.isBiometric != true) {
            Get.to(
              () => BioMetricView(
                accountModel: data.account ?? const AccountModel(),
                userModel: data.user ?? UserModel(),
              ),
            );
          } else {
            Get.offNamed(mainPage);
          }
        } else if (status == "REJECTED" || status == "EXPIRED") {
          _statusTimer?.cancel();
          final confirmed = await showNafathRetryDialog();
          if (confirmed) {
            nafathGetCodeApi();
            startStatusPolling();
          }
        } else if (yaqeenProblem == "date_of_birth_problem") {
          _statusTimer?.cancel();
          dob_error = true;
          update();
        } else if (yaqeenProblem == "no_personal_address") {
          _statusTimer?.cancel();
          address_individual_error = true;
          update();
        } else if (yaqeenProblem == "no_company_address") {
          _statusTimer?.cancel();
          address_company_error = true;
          update();
        }
      },
      errorCallback: (error) {
        print("error is $error");
        String? yaqeenProblem = error.account?.yaqeenProblem;
        _statusTimer?.cancel();
        if (yaqeenProblem == "date_of_birth_problem") {
          dob_error = true;
        } else if (yaqeenProblem == "no_personal_address") {
          address_individual_error = true;
        } else if (yaqeenProblem == "no_company_address") {
          address_company_error = true;
        }
        update();
      },
    );
  }

  Future<bool> showNafathRetryDialog() async {
    final result = await showDialog<bool>(
      context: Get.context!,
      builder: (_) => AlertDialog(
        title: Text("nafaz_failed_title".tr),
        content: Text("nafaz_failed_desc".tr),
        actions: [
          TextButton(
            onPressed: _dismissDialogWithFalse,
            child: Text("cancel".tr),
          ),
          TextButton(
            onPressed: () {
              nafathGetCodeApi();
              Navigator.pop(Get.context!, true);
            },
            child: Text("yes".tr),
          ),
        ],
      ),
    );

    return result == true;
  }

  void _dismissDialogWithTrue() => Navigator.pop(Get.context!, true);

  void _dismissDialogWithFalse() => Navigator.pop(Get.context!, false);

  void startStatusPolling() {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      nafathCheckStatusApi();
    });
  }
}
