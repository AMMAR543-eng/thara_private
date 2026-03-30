import 'package:url_launcher/url_launcher_string.dart';
import '../../../../index/index_main.dart';

class ContactSectionWidget extends StatelessWidget {
  final Map<String, InfoItem> map;

  const ContactSectionWidget({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    final colors = ColorMappingImpl();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "contact_us".tr,
          style: context.typography.myriadSemi46Black.copyWith(
            color: colors.textDisplay,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "you_can_reach_us_through".tr,
          style: context.typography.myriadRegular29Grey.copyWith(
            color: colors.textSecondaryParagraph,
          ),
        ),
        SizedBox(height: 20.h),

        _buildCard(
          context,
          icon: Icons.mail,
          title: "info@tharaco.sa",
          subtitle: "email_us".tr,
          onTap: () => launchUrlString("mailto:info@tharaco.sa"),
        ),
        SizedBox(height: 20.h),

        _buildCard(
          context,
          icon: Icons.phone,
          title: "8001240393",
          subtitle: "call_us".tr,
          onTap: () => launchUrlString("tel:8001240393"),
        ),
        SizedBox(height: 15.h),

        _buildCard(
          context,
          icon: Icons.mail,
          title: "care@tharaco.sa",
          subtitle: "email_us".tr,
          onTap: () => launchUrlString("mailto:care@tharaco.sa"),
        ),
        SizedBox(height: 15.h),

        _buildCard(
          context,
          icon: Icons.lock_clock,
          title: "working_hours_text".tr,
          subtitle: "working_hours".tr,
        ),
      ],
    );
  }

  Widget _buildCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        VoidCallback? onTap,
      }) {
    final colors = ColorMappingImpl();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.borderNeutralPrimary),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.typography.myriadSemi29Black.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    subtitle,
                    style: context.typography.myriadRegular29Grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
