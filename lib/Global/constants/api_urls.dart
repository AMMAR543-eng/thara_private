// ignore_for_file: constant_identifier_names

enum Environment { dev, prod }

class ApiConstatns {
  ApiConstatns._();

  /// =========================
  /// 🌍 ENV
  /// =========================

  static Environment _env = Environment.dev;

  static void setEnv(Environment env) {
    _env = env;
  }

  /// =========================
  /// 🔥 BASE API
  /// =========================

  static String get Base_Url {
    switch (_env) {
      case Environment.dev:
        return 'https://stage.tp.tharaco.sa/api/v1/';
      case Environment.prod:
        return 'https://tp.tharaco.sa/api/v1/';
    }
  }

  /// =========================
  /// 🌐 BASE WEB
  /// =========================

  static String get Base_Web {
    switch (_env) {
      case Environment.dev:
        return 'https://stage.tharaco.sa/';
      case Environment.prod:
        return 'https://tharaco.sa/';
    }
  }

  /// =========================
  /// 🔐 SECURITY (FIXED)
  /// =========================

  /// DEV KEYS
  static const String _devKey =
      "XoaN3rC9R5Lj3E9bCzZLsmaoJQkrCcrp";

  static const String _devIV =
      "XRx6W20dkwJe3PUI"; // لازم 16 char

  /// PROD KEYS
  static const String _prodKey =
      "AJtOZlC7tLIoR9wYaG80A89xckqmIwLK";

  static const String _prodIV =
      "gOTZf9paGJe8P0IX"; // لازم 16 char

  /// 🔑 KEY
  static String get key_encryption {
    const key = String.fromEnvironment('KEY_ENCRYPTION');

    if (key.isNotEmpty) return key;

    print("⚠️ KEY_ENCRYPTION missing → using fallback");

    return _env == Environment.prod ? _prodKey : _devKey;
  }

  /// 🔐 IV
  static String get inv_encryption {
    const iv = String.fromEnvironment('IV_ENCRYPTION');

    if (iv.isNotEmpty && iv.length == 16) return iv;

    print("⚠️ IV invalid or missing → using fallback");

    return _env == Environment.prod ? _prodIV : _devIV;
  }

  static const Map<String, String> header = {
    'Content-Type': 'application/json',
  };

  /// =========================
  /// 🧠 BUILDERS
  /// =========================

  static String _url(String path) => '$Base_Url$path';

  static String _urlWithId(String path, String id) =>
      '$Base_Url$path/$id';

  static String _web(String path) => '$Base_Web$path';

  /// =========================
  /// 🌐 API URLS
  /// =========================

  static String get tradeAccountUrl => _url('trade_account');
  static String get deposites => _url('deposits');

  static String get withdrawal_requests =>
      _url('withdrawal_requests');

  static String get bank_accounts => _url('bank_accounts');
  static String get bankAddress => _url('bank_accounts/create');
  static String get storeBank => _url('bank_accounts/store');

  static String get opportunitiesUrl => _url('opportunities');

  static String opportunityById(String id) =>
      _urlWithId('opportunities', id);

  static String get invests => _url('subscriptions');

  static String subscribe(String id) =>
      _url('opportunities/$id/subscribe');

  static String cancelSubscription(String id) =>
      _url('opportunities/$id/cancel_subscription');

  static String get subscriptionsUrl => _url('subscriptions');

  static String get summaryUrl => _url('dashboard/summary');

  static String monthlyProfitsUrl(String year) =>
      _url('dashboard/monthly_profits?year=$year');

  static String checkWalletPayment(String id) =>
      _urlWithId('wallet/check_payment', id);

  static String get walletPayment => _url('wallet/payment');

  static String get loginUrl => _url('login');
  static String get verifyOtpUrl => _url('verify-two-factor');
  static String get resendOtpUrl => _url('resend-two-factor-code');

  static String get meUrl => _url('me');
  static String get profile => _url('profile');
  static String get logoutUrl => _url('logout');

  static String get resetPassword => _url('reset-password');

  static String get initialResetPasswordUrl =>
      _url('reset-password-request');

  static String get citizenShips => _url('citizen_ships');

  static String get registerEmail => _url('register/email');
  static String get registerResendOtp =>
      _url('register/resend/otp');
  static String get registerVerifyOtp =>
      _url('register/verify/email');

  static String get registerBasicInfo =>
      _url('register/account/basic_info');

  static String get nafathGetCode =>
      _url('register/nafath/get/code');

  static String get nafathCheckStatus =>
      _url('register/nafath/check/status');

  static String get nafathLoginGetCode =>
      _url('nafath_authentication/get_code');

  static String get nafathLoginCheckStatus =>
      _url('nafath_authentication/check_status');

  static String get registerKYCQuestions =>
      _url('register/kyc');

  static String get singingAgreementDetails =>
      _url('register/signing/agreement/review');

  static String get singingWithSirar =>
      _url('register/signing/agreement');

  static String get upddatePassword =>
      _url('update-password');

  static String get changePassword =>
      _url('profile/change_password');

  static String get changeEmailRequestOtp =>
      _url('profile/request_change_email_otp');

  static String get changeEmailSubmit =>
      _url('profile/request_change_email');

  static String get verifyEmail =>
      _url('profile/verify_new_email');

  static String get BIOMETRIC =>
      _url('biometrics/store');

  static String get changePhoneRequestOtp =>
      _url('profile/change_phone_number_otp');

  static String get changePhoneSubmit =>
      _url('profile/change_phone_number');

  static String get change_profile_photo =>
      _url('profile/change_profile_photo');

  static String get verifyPhone =>
      _url('profile/verify_new_phone');

  static String get storeTicket =>
      _url('tickets/store');

  static String get deleteMyProfile =>
      _url('profile/delete-account');

  static String get article => _url('articles');

  static String get faq => _url('pages/faqs');

  static String get finicial =>
      _url('pages/financial_statements');

  static String get upgrade_professional =>
      _url('request/upgrade_to_professional_investor');

  static String get autoInvestmentConfig =>
      _url('auto_invest_config');

  static String get autoInvestmentConfigDelete =>
      _url('auto_invest_config/update_status');

  /// =========================
  /// 🌍 WEB URLS
  /// =========================

  static String opportunityWeb(String id) =>
      _web('opportunities/$id');

  static String get about => _web('about');

  static String get articlesWeb => _web('articles');

  static String get rei => _web('rei');

  static String get home => _web('');

  static String get credit => _web('credit-scoring');
}