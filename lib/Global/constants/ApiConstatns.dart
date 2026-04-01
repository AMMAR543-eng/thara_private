// ignore_for_file: constant_identifier_names

class ApiConstatns {
  ApiConstatns._();

  static const Map<String, String> header = {
    "Content-Type": "application/json",
  };

  //stage
  static const String Base_Url = "https://stage.tp.tharaco.sa/api/v1/";
  static const String key_encryption = "XoaN3rC9R5Lj3E9bCzZLsmaoJQkrCcrp";
  static const String inv_encryption = "XRx6W20dkwJe3PUI";
  // com.tharaco.sa
  // com.thara.thara
  // live
  // static const String Base_Url = "https://tp.tharaco.sa/api/v1/";
  // static const String key_encryption = "AJtOZlC7tLIoR9wYaG80A89xckqmIwLK";
  // static const String inv_encryption = "gOTZf9paGJe8P0IX";

  static const String tradeAccountUrl = "trade_account";
  static const String deposites = "deposits";

  static const String withdraws = "withdrawal_requests";
  static const String bank_accounts = "bank_accounts";
  static const String bankAddress = "bank_accounts/create";
  static const String storeBank = "bank_accounts/store";
  static const String withdrawal_requests = "withdrawal_requests/";
  static const String opportunitiesUrl = "opportunities";
  static const String invests = "subscriptions";
  static const String opportunityIdUrl = "opportunities/";
  static const String cancelSubscriptionUrl =
      "opportunities/:opporunityId/cancel_subscription";
  static const String subscribeUrl = "opportunities/:opportunityId/subscribe";
  static const String summaryUrl = "dashboard/summary";
  static const String monthlyProfitsUrl = "dashboard/monthly_profits?year=";
  static const String checkWalletPayment = "wallet/check_payment/";
  static const String walletPayment = "wallet/payment";

  static const String subscriptionsUrl = "subscriptions";
  static const String loginUrl = "login";
  static const String verifyOtpUrl = "verify-two-factor";
  static const String resendOtpUrl = "resend-two-factor-code";
  static const String meUrl = "me";
  static const String profile = "profile";
  static const String logoutUrl = "logout";
  static const String initialResetPasswordUrl = "reset-password-request";
  static const String resetPassword = "reset-password";
  static const String citizenShips = "citizen_ships";
  static const String registerEmail = "register/email";
  static const String registerResendOtp = "register/resend/otp";
  static const String registerVerifyOtp = "register/verify/email";
  static const String registerBasicInfo = "register/account/basic_info";
  static const String nafathGetCode = "register/nafath/get/code";
  static const String nafathCheckStatus = "register/nafath/check/status";
  static const String nafathLoginGetCode = "nafath_authentication/get_code";
  static const String nafathLoginCheckStatus =
      "nafath_authentication/check_status";
  static const String registerKYCQuestions = "register/kyc";
  static const String singingAgreementDetails =
      "register/signing/agreement/review";
  static const String singingWithSirar = "register/signing/agreement";
  static const String udpdatePassword = "update-password";
  static const String changePassword = "profile/change_password";
  static const String changeEmail = "profile/request_change_email";
  static const String verifyEmail = "profile/verify_new_email";
  static const String BIOMETRIC = "biometrics/store";
  static const String changePhone = "profile/change_phone_number";
  static const String change_profile_photo = "profile/change_profile_photo";
  static const String verifyPhone = "profile/verify_new_phone_number";

  static const String storeTicket = "tickets/store";
  static const String deleteMyProfile = "profile/delete-account";
  static const String article = "articles";
  static const String faq = "pages/faqs";
  static const String finicial = "pages/financial_statements";
  static const String upgrade_professional =
      "request/upgrade_to_professional_investor";

  static const String autoInvestmentConfig = "auto_invest_config";
  static const String autoInvestmentConfigDelete =
      "auto_invest_config/update_status";
}
