import 'package:thara/index/index_main.dart';
import '../ContactUs/ContactUsView.dart';

class SettingsContactWidget extends StatelessWidget {
  const SettingsContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.grayMedium.withAlpha(128),
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            SettingsItemWidget(
              title: "contact_us".tr,
              icon: IconsConstants.contactSettings,
              onTap: () {
                Get.to(
                      () => const ContactUsView(),
                  duration: const Duration(milliseconds: 0),
                  binding: Binding(),
                );
              },
            ),
            Divider(
              color: AppColors.grayMedium.withAlpha(128),
              endIndent: 20.h,
              indent: 20.h,
            ),
            SettingsItemWidget(
              title: "support_tickets".tr,
              icon: IconsConstants.ticketSettings,
              onTap: () => Get.toNamed(settingsTicketView),
            ),
          ],
        ),
      ),
    );
  }
}
