import 'package:url_launcher/url_launcher.dart';

import '../../../../index/index_main.dart';

class ForceUpdateView extends StatelessWidget {
  const ForceUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Images.logo,
            fit: BoxFit.fill,
            width: 300.w,
            height: 300.h,
          ),

          Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
              bottom: 35,
              left: 20,
              right: 20,
            ),
            child: Text(
              "لمواصلة استخدام ذري ، يرجى تحديث التطبيق للوصول إلى أحدث الميزات والتحسينات.",
              style: context.typography.myriadRegular33Grey.copyWith(
                color: AppColors.background_black,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (ConstantsData.deviceType() == "ios") {
                // ios
                await _launchUrl(Strings.url_ios);
              } else {
                // android
                await _launchUrl(Strings.url_android);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 1,
              fixedSize: const Size(300, 55),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: Text(
              "تحديث",
              style: context.typography.myriadSemi46Black.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await canLaunchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    } else {
      await launchUrl(Uri.parse(url));
    }
  }
}
