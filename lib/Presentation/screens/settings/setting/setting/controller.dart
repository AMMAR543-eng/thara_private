import 'dart:io';

import 'package:thara/index/index_main.dart';

class SettingController extends GetxController {
  /// --- User Profile Data
  BaseEntity? profileData;
  UserInfoModel? userInfoModel;

  bool get hasProfileData => profileData != null;

  bool get hasUserInfo => userInfoModel != null;

  /// --- Face ID Switch State
  bool faceIDEnabled = false;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  /// ✅ Ensure data loads in sequence to avoid race condition
  Future<void> _initializeData() async {
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      // await getMeData();
      _loadUserProfile();
      _initFaceIDState(); // ✅ Load local biometric preference
      //getBankAccounts()
    }
  }

  // ---------------------------------------------------------------------------
  void _initFaceIDState() {
    try {
      final bioModel = BioUserModel.getBioData();
      if (bioModel != null && bioModel.isBiometric == true) {
        faceIDEnabled = true;
      } else {
        faceIDEnabled = false;
      }
      print("🔐 Face ID initial state: $faceIDEnabled");
    } catch (e) {
      print("⚠️ Error loading BioUserModel: $e");
      faceIDEnabled = false;
    }
    update();
  }

  // ---------------------------------------------------------------------------
  // 🔐 Toggle Face ID (and persist locally)
  // ---------------------------------------------------------------------------
  void toggleFaceID(bool value) async {
    faceIDEnabled = value;
    update();

    // Save the new value locally via BioUserModel
    final existing = BioUserModel.getBioData();
    final bioModel = BioUserModel(
      bioToken: existing?.bioToken ?? "",
      uuid: existing?.uuid ?? "",
      isBiometric: value,
    );
    await bioModel.saveBioLocal();
    print("💾 Updated Face ID preference locally: $value");
  }

  // ---------------------------------------------------------------------------
  // 🧩 Load Real User Profile
  // ---------------------------------------------------------------------------
  void _loadUserProfile() {
    final tokenData = LoginResponseModel().getTokenData();

    if (tokenData == null || tokenData.data?.accessToken == null) {
      // Guest user (not logged in)
      profileData = null;
      userInfoModel = null;
      update();
      return;
    }

    /// ✅ Fetch user base account info
    AuthService().me(
      voidCallBack: (data) {
        profileData = data;
        update();
      },
    );

    /// ✅ Fetch detailed Nafath user info (personal + company)
    AuthService().profileData(
      voidCallBack: (data) {
        userInfoModel = data;
        update();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 🔄 Public API to Refresh Manually
  // ---------------------------------------------------------------------------
  void refreshProfile() {
    _loadUserProfile();
  }

  // ---------------------------------------------------------------------------
  // 🖼️ Profile Photo Upload (✅ NEW)
  // ---------------------------------------------------------------------------
  Future<void> changeProfilePhoto() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked == null) return;

      final imageFile = File(picked.path);

      AuthService().uploadProfileImage(
        imagePath: imageFile.path,
        voidCallBack: (data) {
          Loader.showSuccess("تم تحديث صورة الملف الشخصي بنجاح ✅");
          refreshProfile();
        },
      );
    } catch (e) {
      Loader.showError("حدث خطأ أثناء رفع الصورة");
    }
  }

  Future<void> deleteProfilePhoto() async {
    AuthService().uploadProfileImage(
      voidCallBack: (data) {
        Loader.showSuccess("تم تحديث صورة الملف الشخصي بنجاح ✅");
        refreshProfile();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 🚪 Logout
  // ---------------------------------------------------------------------------
  void logout() {
    showLogoutDialog(Get.context!);
  }

  // ---------------------------------------------------------------------------
  // 🔑 Change Password
  // ---------------------------------------------------------------------------
  void changePasswordApi(
    String oldPassword,
    String password,
    String passwordConfirm,
  ) {
    SettingsService().changePassword(
      oldPassword: oldPassword,
      password: password,
      passwordConfirm: passwordConfirm,
      voidCallBack: (data) {
        if (data.customStatusCode == 200) {
          Get.back();
          Loader.showSuccess("تم تغيير كلمة المرور بنجاح");
        }
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 🎟️ Support Ticket
  // ---------------------------------------------------------------------------
  void storeTicketApi(String name, String phone, String type, String message) {
    SettingsService().storeTicket(
      name: name,
      phone: phone,
      type: type,
      message: message,
      voidCallBack: (data) {
        if (data.customStatusCode == 200) {
          Loader.showSuccess("تم إرسال التذكرة بنجاح");
          Get.back();
        }
      },
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const LogoutDialog());
  }

  // ---------------------------------------------------------------------------
  // 🧭 Navigation & Actions
  // ---------------------------------------------------------------------------
  void goToPersonalInfo() => Get.toNamed(settingsBasicInfoView);

  void goToAccountSettings() => Get.toNamed(accountSettingsView);

  void showLanguageBottomSheet(BuildContext context, AppLanguage controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: AppColors.white,
      builder: (_) {
        final currentLang = controller.appLocale;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'choose_language'.tr,
                  style: context.typography.bodyStrongLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'arabic'.tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  trailing: currentLang == 'ar'
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () async {
                    Loader.show();
                    if (currentLang != 'ar') {
                      controller.changeLanguage('ar');
                    }
                    // Show loading dialog

                    // Wait 2 seconds
                    await Future.delayed(const Duration(seconds: 2));

                    Loader.dismiss();

                    // Restart routing and go Home

                    Get.back();

                    // Restart routing and go Home
                    Get.offAllNamed(mainPage);
                  },
                ),
                ListTile(
                  title: Text(
                    'english'.tr,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  trailing: currentLang == 'en'
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () async {
                    // Show loading dialog
                    Loader.show();
                    if (currentLang != 'en') {
                      controller.changeLanguage('en');
                    }

                    // Wait 2 seconds
                    await Future.delayed(const Duration(seconds: 2));

                    Loader.dismiss();

                    // Restart routing and go Home
                    Get.back();

                    Get.offAllNamed(mainPage);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void changePassword() => Get.toNamed(settingsChangePassView);

  void manageDevices() => Get.toNamed(settingsView);

  void manageNotifications() => Get.toNamed(settingsNotificationView);

  void openTicket() => Get.toNamed(settingsTicketView);

  void showFAQ() => Get.toNamed(faqView);

  // void aboutThara() => Get.toNamed(aboutUsView);

  void showCompliance() => Get.toNamed(islamicShariaa);

  void financial_report() => Get.toNamed(finanicalReportsView);

  void terms() => Get.toNamed(termsConditions);

  void aboutThara() => launchUrl(Uri.parse("https://tharaco.sa/about"));

  void articles() => launchUrl(Uri.parse("https://tharaco.sa/articles"));

  void indicators() => launchUrl(Uri.parse("https://tharaco.sa/rei"));

  void openWebsite() => launchUrl(Uri.parse("https://tharaco.sa/"));

  void creditRating() =>
      launchUrl(Uri.parse("https://tharaco.sa/credit-scoring"));
}
