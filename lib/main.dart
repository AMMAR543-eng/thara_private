import 'index/index_main.dart'; // Your custom imports
import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// 🔥 INIT FIREBASE
      await Firebase.initializeApp();

      /// 🔥 CRASHLYTICS (Flutter errors)
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      /// 🔥 CRASHLYTICS (Dart / Platform errors)
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(
          error,
          stack,
          fatal: true,
        );
        return true;
      };

      await GetStorage.init();
      await StorageService().init();

      // ✅ SECURITY CHECK
      final compromised = await isDeviceCompromised();
      if (compromised) {
        runApp(const RootBlockedApp());
        return;
      }

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      Binding().dependencies();

      /// ✅ ENV
      ApiConstatns.setEnv(Environment.dev);

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

    /// 🔥 GLOBAL ERROR HANDLER (fallback)
    (dynamic error, dynamic stack) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );

      debugPrint("🔥 ERROR: $error");
      debugPrint("📍 STACK: $stack");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  String getLocalLan() {
    final localStorage = LocalStorage_language();
    return localStorage.read();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
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
