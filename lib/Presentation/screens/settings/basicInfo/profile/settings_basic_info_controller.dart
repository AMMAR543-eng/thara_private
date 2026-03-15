import 'package:intl/intl.dart';
import 'package:thara/Presentation/screens/settings/basicInfo/change_email/controller.dart';
import 'package:thara/Presentation/screens/settings/basicInfo/change_phone/controller.dart';
import 'package:thara/Presentation/screens/settings/delete_account.dart';
import '../../../../../index/index_main.dart';

class SettingsBasicInfoController extends GetxController {
  BaseEntity? profileData;
  UserInfoModel? userInfoModel;

  /// Accessors
  bool get hasProfileData => profileData != null;

  bool get hasUserInfo => userInfoModel != null;

  AccountModel? get account => profileData?.account;

  @override
  void onInit() {
    super.onInit();
    getUserProfileData();
    getProfileData();
  }

  String formatNumber(num? number, {int decimals = 2}) {
    if (number == null) return "0.00";
    final isArabic = LocalStorage_language().read() == "ar";
    final format = NumberFormat.decimalPattern(isArabic ? "ar" : "en");
    format.minimumFractionDigits = decimals;
    format.maximumFractionDigits = decimals;
    return format.format(number);
  }

  String get investmentUsageText {
    final limitation = userInfoModel?.investmentLimitation ?? 0;
    final active = userInfoModel?.activeInvestmentBalance ?? 0;
    if (limitation == 0) return "0 / 0%";
    final formattedActive = formatNumber(active, decimals: 2);
    final percentage = (active / limitation) * 100;
    return " $formattedActive / ${percentage.toStringAsFixed(0)}%";
  }

  double get investmentProgress {
    final limitation = userInfoModel?.investmentLimitation ?? 0;
    final active = userInfoModel?.activeInvestmentBalance ?? 0;
    if (limitation == 0) return 0.0;
    return active / limitation;
  }


  // ---------------------------------------------------------------------------
  // 🔹 Fetch Data
  // ---------------------------------------------------------------------------

  void getProfileData() {
    AuthService().me(
      voidCallBack: (data) async {
        profileData = data;
        await profileData?.account?.saveAccountLocal();
        update();
      },
    );
  }

  void getUserProfileData() {
    AuthService().profileData(
      voidCallBack: (data) {
        userInfoModel = data;
        update();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 🗑️ Delete Account
  // ---------------------------------------------------------------------------

  void deleteMyProfileApi(BuildContext context) async {
    final result = await showDeactivateAccountDialog(context);
    if (result == null) return;

    String type = "";
    String? reason;

    if (result is String) {
      type = result;
    } else if (result is Map<String, dynamic>) {
      type = result["type"] ?? "";
      reason = result["reason"];
    }

    if (type.isEmpty) return;

    SettingsService().deleteMyProfile(
      params: DeactivateAccountRequest(type: type, reason: reason),
      voidCallBack: (data) async {
        await LoginResponseModel().deleteTokenLocal();
        await AccountModel().deleteAccountLocal();

        Get.offAllNamed(loginScreen);
        Loader.showSuccess("account_deleted_success".tr);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // ✉️ Email & 📞 Phone Update
  // ---------------------------------------------------------------------------

  void startEmailChangeFlow(BuildContext context) {
    final emailController = Get.put(ChangeEmailController());
    emailController.openEditEmailBottomSheet(context);
  }

  void startPhoneChangeFlow(BuildContext context) {
    final phoneController = Get.put(ChangePhoneController());
    phoneController.openEditPhoneBottomSheet(context);
  }

  // ---------------------------------------------------------------------------
  // 🧩 UI Helpers & Labels
  // ---------------------------------------------------------------------------

  String get accountTypeLabel {
    final type = account?.type;
    if (type == "company") return "account_type_company".tr;
    if (type == "individual") return "account_type_individual".tr;
    return "account_type_unknown".tr;
  }

  String get investingStatusLabel {
    final status = account?.investingAccountStatus;
    if (status == "active") return "status_active".tr;
    if (status == "inactive") return "status_inactive".tr;
    return "status_not_activated".tr;
  }

  String get borrowingStatusLabel {
    final status = account?.borrowingAccountStatus;
    if (status == "active") return "status_active".tr;
    if (status == "pending") return "status_pending".tr;
    return "status_not_applied".tr;
  }

  // ---------------------------------------------------------------------------
  // 🧠 Investor Logic (Unified & Localized)
  // ---------------------------------------------------------------------------

  String get investorLevel {
    final acc = account;
    if (acc == null) return "-";

    if (acc.isProfessionalInvestor == true &&
        acc.thereIsWaitingRequest == false) {
      return "investor_professional".tr;
    }

    if (acc.isProfessionalInvestor == true &&
        acc.thereIsWaitingRequest == true) {
      return "investor_upgrade_pending".tr;
    }

    if (acc.verifiedAsInvestor == true &&
        acc.isProfessionalInvestor == false &&
        acc.thereIsWaitingRequest == false) {
      return "investor_upgrade_request".tr;
    }

    return "investor_unverified".tr;
  }

  bool get isInvestorVerified => account?.verifiedAsInvestor == true;

  bool get isProfessionalInvestor =>
      account?.isProfessionalInvestor == true &&
      account?.thereIsWaitingRequest == false;

  bool get isWaitingProfessional => account?.thereIsWaitingRequest == true;

  bool get canUpgradeToProfessional =>
      (isInvestorVerified && !isProfessionalInvestor && !isWaitingProfessional);

  bool get showVerifiedBadge =>
      isProfessionalInvestor || isWaitingProfessional || isInvestorVerified;

  String get verifiedBadgeLabel {
    if (isProfessionalInvestor) return "investor_professional".tr;
    if (isWaitingProfessional) return "investor_upgrade_pending".tr;
    if (isInvestorVerified) return "investor_verified".tr;
    return "";
  }

  Color get verifiedBadgeColor {
    if (isProfessionalInvestor) return AppColors.content_positive_secondary;
    if (isWaitingProfessional) return AppColors.action_primary_normal;
    if (isInvestorVerified) return AppColors.content_secondary;
    return AppColors.tertiary;
  }
}
