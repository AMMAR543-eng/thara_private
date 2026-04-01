import '../index/index_main.dart';

const String mainPage = "/MainPage";
const String test = "/Test";
const String processView = "/ProcessView";
const String loginScreen = "/LoginScreen";
const String forgetPasswordScreen = "/forgetPasswordScreen";
const String otpScreen = "/otpScreen";
const String resetPasswordScreen = "/resetPasswordScreen";
const String resetCompleteScreen = "/resetCompleteScreen";
const String dashboardScreen = "/dashboardScreen";
const String register = "/register";
const String registerInfo = "/registerInfo";
const String registerTerms = "/registerTerms";
const String registerNafaz = "/registerNafaz";
const String registerKYC = "/registerKYC";
const String registerIndividualsWork = "/registerIndividualsWork";
const String registerSigning = "/registerSigning";
const String storeBankView = "/StoreBankView";
const String settingsView = "/settingsView";
const String settingsBankInfoView = "/settingsBankInfoView";
const String settingsBasicInfoView = "/settingsBasicInfoView";
const String settingsKYCInfoView = "/settingsKYCInfoView";
const String settingsNotificationView = "/settingsNotificationView";
const String settingsTicketView = "/settingsTicketView";
const String settingsChangePassView = "/settingsChangePassView";
const String opportunityDetailsView = "/OpportunityDetailsView";
const String allInvestementsView = "/AllInvestementsView";
const String splashScreen = "/SplashScreen";
const String updatePasswordScreen = "/UpdatePasswordScreen";
const String underReview = "/UnderReview";
const String successAuthView = "/SuccessAuthView";
const String bankTransferView = "/BankTransferView";
const String finanicalReportsView = "/FinanicalReportsView";
const String upgradetoprofessionalview = "/Upgradetoprofessionalview";
const String forceUpdateView = "/ForceUpdateView";
const String onboardingScreen = "/OnboardingScreen";
const String bioMetricView = "/BioMetricView";
const String notificationsView = "/NotificationsView";
const String walletView = "/WalletView";
const String settingView = "/SettingView";
const String accountSettingsView = "/AccountSettingsView";
const String faqView = "/FaqView";
const String aboutUsView = "/AboutUsView";
const String islamicShariaa = "/IslamicShariaa";
const String termsConditions = "/TermsConditions";
const String articlesView = "/ArticlesView";
const String settingNewView = "/SettingView";
const String loginNafazScreen = "/LoginNafazScreen";

class Routes {
  /// 🔥 helper بدل التكرار
  static GetPage _page({
    required String name,
    required Widget Function() page,
    List<GetMiddleware>? middlewares,
  }) {
    return GetPage(
      name: name,
      page: page,
      binding: Binding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 0),
      middlewares: middlewares,
    );
  }

  static List<GetPage<dynamic>> handle_routes() {
    return [
      _page(
        name: mainPage,
        page: () => MainPage(),
        middlewares: [RouteWelcomeMiddleWare(priority: 1)],
      ),
      _page(
        name: processView,
        page: () => const ProcessView(),
      ),
      _page(
        name: loginNafazScreen,
        page: () => const LoginNafazScreen(),
      ),
      _page(
        name: settingNewView,
        page: () => const SettingView(),
      ),
      _page(
        name: termsConditions,
        page: () => const TermsConditions(),
      ),
      _page(
        name: articlesView,
        page: () => const ArticlesView(),
      ),
      _page(
        name: islamicShariaa,
        page: () => const IslamicShariaa(),
      ),
      _page(
        name: aboutUsView,
        page: () => const AboutUsView(),
      ),
      _page(
        name: accountSettingsView,
        page: () => const AccountSettingsView(),
      ),
      _page(
        name: faqView,
        page: () => const FaqView(),
      ),
      _page(
        name: onboardingScreen,
        page: () => const OnboardingScreen(),
      ),
      _page(
        name: notificationsView,
        page: () => const NotificationsView(),
      ),
      _page(
        name: settingView,
        page: () => const SettingView(),
      ),
      _page(
        name: walletView,
        page: () => const WalletView(),
      ),
      _page(
        name: forceUpdateView,
        page: () => const ForceUpdateView(),
      ),
      _page(
        name: bankTransferView,
        page: () => const BankTransferView(),
      ),
      _page(
        name: upgradetoprofessionalview,
        page: () => const Upgradetoprofessionalview(),
      ),
      _page(
        name: finanicalReportsView,
        page: () => const FinanicalReportsView(),
      ),
      _page(
        name: underReview,
        page: () => const UnderReview(),
      ),
      _page(
        name: updatePasswordScreen,
        page: () => const UpdatePasswordScreen(),
      ),
      _page(
        name: successAuthView,
        page: () => const SuccessAuthView(),
      ),
      _page(
        name: opportunityDetailsView,
        page: () => const OpportunityDetailsView(),
      ),
      _page(
        name: test,
        page: () => const Test(),
      ),
      _page(
        name: storeBankView,
        page: () => const StoreBankView(),
      ),
      _page(
        name: loginScreen,
        page: () => const LoginScreen(),
        middlewares: [RouteLoginMiddleWare(priority: 1)],
      ),
      _page(
        name: allInvestementsView,
        page: () => const AllInvestementsView(),
      ),
      _page(
        name: forgetPasswordScreen,
        page: () => const ForgetPasswordScreen(),
      ),
      _page(
        name: resetPasswordScreen,
        page: () => const ResetPasswordScreen(),
      ),
      _page(
        name: resetCompleteScreen,
        page: () => const ResetCompletedScreen(),
      ),
      _page(
        name: register,
        page: () => const RegisterScreen(),
      ),
      _page(
        name: registerInfo,
        page: () => RegisterInfoScreen(),
      ),
      _page(
        name: registerTerms,
        page: () => RegisterTermsScreen(),
      ),
      _page(
        name: registerNafaz,
        page: () => const RegisterNafazScreen(),
      ),
      _page(
        name: registerKYC,
        page: () => const RegisterKYCScreen(),
      ),
      _page(
        name: registerSigning,
        page: () => const RegisterSigningScreen(),
      ),
      _page(
        name: settingsBankInfoView,
        page: () => const SettingsBankInfoView(),
      ),
      _page(
        name: settingsBasicInfoView,
        page: () => const SettingsBasicInfoView(),
      ),
      _page(
        name: settingsKYCInfoView,
        page: () => const SettingsKYCInfoView(),
      ),
      _page(
        name: settingsNotificationView,
        page: () => const SettingsNotificationView(),
      ),
      _page(
        name: settingsTicketView,
        page: () => const SettingsTicketView(),
      ),
      _page(
        name: settingsChangePassView,
        page: () => const SettingsChangePassView(),
      ),
    ];
  }
}
