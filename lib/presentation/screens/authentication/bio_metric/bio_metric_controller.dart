import 'package:dartz/dartz.dart';
import '../../../../index/index_main.dart';

class BiometricLoginViewModel extends GetxController {
  bool? switchValue;
  UserModel? userData;
  BioUserModel? bioUserModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    // await  BioUserModel.deleteBioLocal();
    bioUserModel = BioUserModel.getBioData();
    userData = UserModel().getUserData();
    switchValue = bioUserModel?.isBiometric;
    update();

    // Load user profile if logged in
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      getMeData();
    }
  }

  /// ✅ Check and perform biometric authentication
  Future<void> checkBiometricAuth() async {
    if (userData?.email != null && bioUserModel?.isBiometric == true) {
      final token = await BiometricService.authenticateAndGenerateToken();
      if (token != null) {
        if (bioUserModel?.bioToken == null) {
          await biometricLogin(token);
        } else {
          await loginData();
        }
      } else {
        Loader.showError("Biometric authentication failed");
      }
    } else if (userData?.email != null && bioUserModel?.isBiometric == null) {
      final token = await BiometricService.authenticateAndGenerateToken();

      if (token != null) {
        await biometricLogin(token, isSetting: true);
      } else {
        Loader.showError("Biometric authentication failed");
      }
    } else {
      Loader.showInfo("You need to enable biometric auth from settings".tr);
    }
  }

  Future<void> checkFirstBiometricAuth() async {
    final token = await BiometricService.authenticateAndGenerateToken();
    if (bioUserModel?.bioToken == null) {
      final uuid = await ConstantsData.udid() ?? "";
      await biometricLogin(token ?? "", isSetting: true);
    } else {
      Loader.showError("Biometric authentication failed");
    }
  }

  /// ✅ Toggle biometric activation (from settings screen)
  void updateLocalUser(bool isSetting) {
    final isBiometricEnabled = switchValue == true ? 1 : 0;
    biometricLogin(isBiometricEnabled.toString(), isSetting: isSetting);
  }

  /// ✅ Perform biometric login or enable/disable biometric on backend
  Future<void> biometricLogin(String token, {bool? isSetting}) async {
    try {
      Loader.show();

      final useCase = Get.put(BiometricLoginUseCase(Get.find()));
      final uuid = await ConstantsData.udid() ?? "";

      final result = await useCase(
        BiometricLoginParams(token: token, uuid: uuid),
      );

      result.fold(
        (error) {
          Loader.showError(error.messege);
        },
        (success) async {
          Loader.dismiss();

          final bioUserModel = BioUserModel(
            uuid: uuid,
            bioToken: token,
            isBiometric: true,
          );
          await bioUserModel.saveBioLocal();

          if (isSetting != true) {
            await loginData();
          } else {
            // skip biometric
            handleUserNavigation(
              account: success.account ?? const AccountModel(),
              user: success.user ?? UserModel(),
            );
          }

          update();
        },
      );
    } catch (e) {
      Loader.dismiss();
      Loader.showError("An error occurred during biometric login: $e");
    }
  }

  /// ✅ Check if biometric is available and user has email
  bool isBiometricAvailable() {
    return userData?.email != null && bioUserModel?.isBiometric == true;
  }

  /// ✅ Get user info from server (refresh)
  Future<void> getMeData() async {
    final completer = Completer<void>();
    AuthService().me(
      voidCallBack: (data) async {
        // You can save updated user info here if needed
        completer.complete();
      },
    );
    return completer.future;
  }

  /// ✅ Perform login flow after biometric verification
  Future<void> loginData() async {
    AuthService().login(
      params: LoginParams(
        biometrics: "active",
        token: bioUserModel?.bioToken,
        udid: bioUserModel?.uuid,
      ),
      voidCallBack: (loginModel) {
        final user = loginModel.user;

        loginModel.saveTokenLocal();

        final token = loginModel.data?.accessToken;
        if (token != null && token.isNotEmpty) {
          handleUserNavigation(
              account: loginModel.account ?? const AccountModel(),
              user: user ?? UserModel(),
              is_biometric: true);
        }
      },
    );
  }
}
