// ignore_for_file: overridden_fields

import '../../index/index_main.dart';

class RouteWelcomeMiddleWare extends GetMiddleware {
  @override
  final int? priority;

  RouteWelcomeMiddleWare({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    final token = LoginResponseModel().getTokenData()?.data?.accessToken;
    bool? firstLaunch = StorageService().getData("firstLaunch");

    debugPrint("🔐 token: $token");
    debugPrint("🚀 firstLaunch: $firstLaunch");

    // 1️⃣ First Launch → Onboarding
    if (firstLaunch == true || firstLaunch == null) {
      return const RouteSettings(name: onboardingScreen);
    }

    // 2️⃣ No Token → Go to Main Page
    if (token == null) {
      return null;
    }

    // 3️⃣ Token Found → Go to Login
    return null;
  }
}




class RouteLoginMiddleWare extends GetMiddleware {
  @override
  final int? priority;

  RouteLoginMiddleWare({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    final token = LoginResponseModel().getTokenData()?.data?.accessToken;
    bool? firstLaunch = StorageService().getData("firstLaunch");

    debugPrint("🔐 token: $token");
    debugPrint("🚀 firstLaunch: $firstLaunch");

    // 1️⃣ First Launch → Onboarding
    if (firstLaunch == true || firstLaunch == null) {
      return const RouteSettings(name: onboardingScreen);
    }


    // 3️⃣ Token Found → Go to Login
    return null;
  }
}
