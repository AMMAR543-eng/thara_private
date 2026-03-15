import 'package:thara/Presentation/screens/settings/about_us.dart';
import 'package:thara/Presentation/screens/settings/articles/articles_view.dart';
import 'package:thara/Presentation/screens/settings/faq/faqView.dart';
import 'package:thara/Presentation/screens/settings/shri3a.dart';
import 'package:thara/Presentation/screens/settings/terms/terms.dart';

import '../Presentation/screens/authentication/nafaz_login/login_nafaz_view.dart';
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
  static List<GetPage<dynamic>> handle_routes() {
    return [
      GetPage(
        name: mainPage,
        page: () => MainPage(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
        middlewares: [RouteWelcomeMiddleWare(priority: 1)],
      ),

      GetPage(
        name: processView,
        page: () => const ProcessView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: loginNafazScreen,
        page: () => const LoginNafazScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingNewView,
        page: () => const SettingView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: termsConditions,
        page: () => const TermsConditions(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: articlesView,
        page: () => const ArticlesView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: islamicShariaa,
        page: () => const IslamicShariaa(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: aboutUsView,
        page: () => const AboutUsView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: accountSettingsView,
        page: () => const AccountSettingsView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: faqView,
        page: () => const FaqView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: onboardingScreen,
        page: () => const OnboardingScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: notificationsView,
        page: () => const NotificationsView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingView,
        page: () => const SettingView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: walletView,
        page: () => const WalletView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: forceUpdateView,
        page: () => const ForceUpdateView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: bankTransferView,
        page: () => const BankTransferView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: upgradetoprofessionalview,
        page: () => const Upgradetoprofessionalview(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: finanicalReportsView,
        page: () => const FinanicalReportsView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: underReview,
        page: () => const UnderReview(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: updatePasswordScreen,
        page: () => const UpdatePasswordScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: successAuthView,
        page: () => const SuccessAuthView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: opportunityDetailsView,
        page: () => const OpportunityDetailsView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: test,
        page: () => const Test(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: storeBankView,
        page: () => const StoreBankView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: loginScreen,
        page: () => const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
        middlewares: [RouteLoginMiddleWare(priority: 1)],
      ),
      GetPage(
        name: allInvestementsView,
        page: () => const AllInvestementsView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: forgetPasswordScreen,
        page: () => const ForgetPasswordScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: resetPasswordScreen,
        page: () => const ResetPasswordScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: resetCompleteScreen,
        page: () => const ResetCompletedScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: register,
        page: () => const RegisterScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: registerInfo,
        page: () => RegisterInfoScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: registerTerms,
        page: () => RegisterTermsScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: registerNafaz,
        page: () => const RegisterNafazScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: registerKYC,
        page: () => const RegisterKYCScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: registerSigning,
        page: () => const RegisterSigningScreen(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),

      GetPage(
        name: settingsBankInfoView,
        page: () => const SettingsBankInfoView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingsBasicInfoView,
        page: () => const SettingsBasicInfoView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingsKYCInfoView,
        page: () => const SettingsKYCInfoView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingsNotificationView,
        page: () => const SettingsNotificationView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingsTicketView,
        page: () => const SettingsTicketView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
      GetPage(
        name: settingsChangePassView,
        page: () => const SettingsChangePassView(),
        transitionDuration: const Duration(milliseconds: 0),
        binding: Binding(),
        transition: Transition.cupertino,
      ),
    ];
  }
}
