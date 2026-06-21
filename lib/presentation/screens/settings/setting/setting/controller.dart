import 'dart:io';
import 'package:thara/global/constants/api_urls.dart';
import 'package:thara/index/index_main.dart';

class SettingController extends GetxController {
  BaseEntity? profileData;
  UserInfoModel? userInfoModel;

  bool get hasProfileData => profileData != null;

  bool get hasUserInfo => userInfoModel != null;

  bool faceIDEnabled = false;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> _initializeData() async {
    if (LoginResponseModel().getTokenData()?.data?.accessToken != null) {
      _loadUserProfile();
      _initFaceIDState();
    }
  }

  void _initFaceIDState() {
    try {
      final bioModel = BioUserModel.getBioData();
      faceIDEnabled = bioModel?.isBiometric == true;
    } catch (e) {
      faceIDEnabled = false;
    }
    update();
  }

  void toggleFaceID(bool value) async {
    faceIDEnabled = value;
    update();

    final existing = BioUserModel.getBioData();
    final bioModel = BioUserModel(
      bioToken: existing?.bioToken ?? "",
      uuid: existing?.uuid ?? "",
      isBiometric: value,
    );
    await bioModel.saveBioLocal();
  }

  void _loadUserProfile() {
    final tokenData = LoginResponseModel().getTokenData();

    if (tokenData == null || tokenData.data?.accessToken == null) {
      profileData = null;
      userInfoModel = null;
      update();
      return;
    }

    AuthService().me(
      voidCallBack: (data) {
        profileData = data;
        update();
      },
    );

    AuthService().profileData(
      voidCallBack: (data) {
        userInfoModel = data;
        update();
      },
    );
  }

  void refreshProfile() {
    _loadUserProfile();
  }

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
          Loader.showSuccess("تم تحديث صورة الملف الشخصي بنجاح ");
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
        Loader.showSuccess("تم تحديث صورة الملف الشخصي بنجاح ");
        refreshProfile();
      },
    );
  }

  void logout() {
    showLogoutDialog(Get.context!);
  }

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

  // =========================
  // 🧭 Navigation
  // =========================

  void goToPersonalInfo() => Get.toNamed(settingsBasicInfoView);

  void goToAccountSettings() => Get.toNamed(accountSettingsView);

  void changePassword() => Get.toNamed(settingsChangePassView);

  void manageDevices() => Get.toNamed(settingsView);

  void manageNotifications() => Get.toNamed(settingsNotificationView);

  void openTicket() => Get.toNamed(settingsTicketView);

  void showFAQ() => Get.toNamed(faqView);

  void showCompliance() => Get.toNamed(islamicShariaa);

  void financial_report() => Get.toNamed(finanicalReportsView);

  void terms() => Get.toNamed(termsConditions);

  // =========================
  // 🌍 Web URLs (FIXED 🔥)
  // =========================

  void aboutThara() => launchUrl(Uri.parse(ApiConstatns.about));

  void articles() => launchUrl(Uri.parse(ApiConstatns.articlesWeb));

  void indicators() => launchUrl(Uri.parse(ApiConstatns.rei));

  void openWebsite() => launchUrl(Uri.parse(ApiConstatns.home));

  void creditRating() => launchUrl(Uri.parse(ApiConstatns.credit));

  // =========================
  // 🌐 Language
  // =========================

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

                /// Arabic
                ListTile(
                  title: Text('arabic'.tr),
                  trailing: currentLang == 'ar'
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () async {
                    Loader.show();
                    if (currentLang != 'ar') {
                      controller.changeLanguage('ar');
                    }
                    await Future.delayed(const Duration(seconds: 2));
                    Loader.dismiss();
                    Get.back();
                    Get.offAllNamed(mainPage);
                  },
                ),

                /// English
                ListTile(
                  title: Text('english'.tr),
                  trailing: currentLang == 'en'
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () async {
                    Loader.show();
                    if (currentLang != 'en') {
                      controller.changeLanguage('en');
                    }
                    await Future.delayed(const Duration(seconds: 2));
                    Loader.dismiss();
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
}
