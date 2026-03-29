import '../Global/theme/app_theme_controller.dart';
import '../index/index_main.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    // Core
    Get.lazyPut<ClientSourceRepo>(() => ClientSourceRepo(), fenix: true);
    Get.put(AppLanguage(), permanent: true);

    // Repository Data source _________________________________________________
    Get.lazyPut<ProcessRemoteDataSourceRepo>(
      () => ProcessRemoteDataSourceImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<OpportunitiesRemoteDataSourceRepo>(
      () => OpportunitiesRemoteDataSourceImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<AuthRemoteDataSourceRepo>(
      () => AuthRemoteDataSourceImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<RegisterRemoteDataSourceRepo>(
      () => RegisterRemoteDataSourceImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<SettingsRemoteDataSourceRepo>(
      () => SettingsRemoteDataSourceImpl(Get.find()),
      fenix: true,
    );

    // Repository Domain _________________________________________________
    Get.lazyPut<ProcessRepository>(
      () => ProcessRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<OpportunitiesRepository>(
      () => OpportunitiesRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<RegisterRepository>(
      () => RegisterRepositoryImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<SettingsRepository>(
      () => SettingsRepositoryImpl(Get.find()),
      fenix: true,
    );

    // View models _________________________________________________
    Get.lazyPut<ProcessController>(() => ProcessController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
    Get.lazyPut<RegisterInfoController>(() => RegisterInfoController());
    Get.lazyPut<OtpController>(() => OtpController());
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<RegisterService>(() => RegisterService());
    Get.lazyPut<SettingsService>(() => SettingsService());
    Get.lazyPut<StoreBankController>(() => StoreBankController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<SettingsBankInfoController>(() => SettingsBankInfoController());
    Get.lazyPut<SettingsBasicInfoController>(
      () => SettingsBasicInfoController(),
    );
    Get.lazyPut<SettingsKYCInfoController>(() => SettingsKYCInfoController());
    Get.lazyPut<OpportunityDetailsController>(
      () => OpportunityDetailsController(),
    );
    Get.lazyPut<StatisticsController>(() => StatisticsController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<NafazController>(() => NafazController());
    Get.lazyPut<KYCController>(() => KYCController());
    Get.lazyPut<SigningController>(() => SigningController());
    Get.lazyPut<ArticlesViewModel>(() => ArticlesViewModel());
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.lazyPut<FinancialReportsVieWModel>(() => FinancialReportsVieWModel());
    Get.lazyPut<OpportunitiesController>(() => OpportunitiesController());
    Get.lazyPut<RegisterParentController>(() => RegisterParentController());
    Get.lazyPut<WalletController>(() => WalletController());

    Get.lazyPut<AppThemeController>(() => AppThemeController());
  }
}
