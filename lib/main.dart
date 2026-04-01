import 'index/index_main.dart'; // Your custom imports

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GetStorage.init();

      // // ✅ SECURITY CHECK
      // final compromised = await isDeviceCompromised();
      //
      // if (compromised) {
      //   runApp(const RootBlockedApp());
      //   return;
      // }

      await StorageService().init();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      Binding().dependencies();

      final initializedApp = await ThemeScopeWidget.initialize(const MyApp());

      runApp(
        ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (context, child) => initializedApp,
        ),
      );
    },
    (dynamic error, dynamic stack) {},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Helper function to fetch the locale from storage
  String getLocalLan() {
    final localStorage = LocalStorage_language();
    return localStorage.read();
    // return "ar";
  }

  @override
  Widget build(BuildContext context) {
    // Access the theme context
    final theme = ThemeScope.of(context);

    // Return the GetMaterialApp with all necessary configurations
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      // const SystemUiOverlayStyle(
      //   statusBarBrightness: Brightness.light,
      //   statusBarIconBrightness: Brightness.dark,
      //   systemNavigationBarColor:  Colors.white,
      //   systemNavigationBarIconBrightness: Brightness.dark,
      // ),
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        builder: EasyLoading.init(),
        initialRoute: loginScreen,
        initialBinding: Binding(),
        themeMode: theme.themeMode,
        theme: ThemeData(extensions: [theme.appTheme]),
        darkTheme: ThemeData(extensions: [theme.appTheme]),
        translations: Translation(),
        locale: Locale(getLocalLan()),
        fallbackLocale: Locale(getLocalLan()),
        getPages: Routes.handle_routes(),
        debugShowCheckedModeBanner: false,
        title: 'ذري',
      ),
    );
  }
}
