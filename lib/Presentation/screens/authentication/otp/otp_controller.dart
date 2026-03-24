import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:thara/Global/middleware/auth_middleware.dart';
import '../../../../Data/Models/user_account/bio_metric_model.dart';
import '../../../../index/index_main.dart';

class OtpController extends GetxController {
  /// Timer-related
  final secondsRemaining = 60.obs;
  final enableResend = false.obs;
  Timer? _timer;

  /// Tap-throttle
  bool _resending = false;

  /// OTP validation flag for UI button (if you need it elsewhere)
  bool validOtp = false;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  /// Start or restart the OTP resend timer
  void startTimer([int from = 60]) {
    enableResend.value = false;
    secondsRemaining.value = from;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final next = secondsRemaining.value - 1;
      if (next <= 0) {
        secondsRemaining.value = 0;
        enableResend.value = true;
        timer.cancel();
      } else {
        secondsRemaining.value = next;
      }
    });
  }

  /// Called on OTP input change
  void setOtpValidation(bool isValid) {
    validOtp = isValid;
    update(['otp_button']);
  }

  /// One unified resend entrypoint. It will:
  /// - block double taps
  /// - call the right API (or a custom callback)
  /// - restart timer only on success
  Future<void> resend({
    required OtpPages page,
    String? withdrawId,
    Future<void> Function()? onCustomResend, // for forget or special cases
  }) async {
    if (_resending || !enableResend.value) return;

    _resending = true;
    enableResend.value = false;

    try {
      if (onCustomResend != null) {
        await onCustomResend();
      } else {
        // Wrap callback-based SDKs in a Future so we can await them
        final c = Completer<void>();
        switch (page) {
          case OtpPages.register:
          case OtpPages.registerIndi: // ✅ new case
            RegisterService().resendOtp(voidCallBack: (_) => c.complete());
            await c.future;
            break;

          case OtpPages.login:
            AuthService().resendOtp(voidCallBack: (_) => c.complete());
            await c.future;
            break;

          case OtpPages.forget:
            AuthService().resendOtp(voidCallBack: (_) => c.complete());
            await c.future;
            break;

          case OtpPages.withdraw:
            if (withdrawId == null) {
              throw Exception('withdrawId is required for withdraw resend');
            }
            RegisterService().resendOtp(
              withdraw_id: withdrawId,
              url: "withdrawal_requests/resend/otp",
              voidCallBack: (_) => c.complete(),
            );
            await c.future;
            break;
        }
      }

      // Only on success:
      startTimer();
    } catch (e) {
      // On failure, re-enable the link and notify
      enableResend.value = true;
      Loader.showError("otp_resend_failed".tr);
    } finally {
      _resending = false;
    }
  }

  /// Verify login OTP
  void verifyOtp(String code, void Function()? clear) {
    AuthService().verifyOtp(
      code: code,
      voidCallBack: (data) {
        UserModel? userData = UserModel().getUserData();
        final String? activeStep = data.account?.registrationStage ?? "";
        final bool? nafath = data.account?.nafathCompleted;

        if (activeStep == "finished" &&
            nafath == true &&
            userData?.email != null &&
            BioUserModel.getBioData()?.isBiometric != true) {
          Get.to(
            () => BioMetricView(
              accountModel: data.account ?? const AccountModel(),
              userModel: data.user ?? UserModel(),
            ),
          );
        } else {
          handleUserNavigation(
            account: data.account ?? const AccountModel(),
            user: data.user ?? UserEntity(),
          );
        }

        // handleUserNavigation(
        //   account: data.account ?? const AccountModel(),
        //   user: data.user ?? UserEntity(),
        // );
      },
    );
  }

  /// Verify register OTP
  void registerVerifyOtp(String code, void Function()? clear, bool? isCompany) {
    RegisterService().verifyOtp(
      code: code,
      voidCallBack: (data) {
        if (data.customStatusCode == 200) {
          clear?.call();
          Get.offAll(
            () => RegisterParentView(index: 0, isCompany: isCompany),
            binding: Binding(),
          );
        }
      },
    );
  }

  /// Verify withdraw OTP
  void verifyWithdrawOtp(String id, String code, void Function()? clear) {
    RegisterService().verifyOtp(
      url: "withdrawal_requests/$id/verify",
      code: code,
      voidCallBack: (data) {
        Get.back();
        Loader.showSuccess(data.message ?? "");
        WalletController walletController = initUseCase(
          () => WalletController(),
        );
        walletController.getTradeAccountData();
        walletController.update();
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
