import 'dart:ui';
import '../../../../index/index_main.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorMappingImpl();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.3,
          centerTitle: true,
          title: Text(
            "التنبيهات",
            style: context.typography.bodyStrongLarge.copyWith(
              color: colors.textDisplay,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Column(
                  children: [
                    /// 🔹 1. Pending Transfer
                    _NotificationCard(
                      title: "يوجد لديك حوالة معلقة بمبلغ 1,723.23 ﷼",
                      description:
                          "الرجاء قبول توثيق الحساب المرسل للحوالة أدناه لاستقبال المبلغ",
                      buttons: [
                        PrimaryTextButton(
                          onTap: () {},
                          label: Text(
                            "استعراض الفرصة",
                            style: context.typography.bodyLarge,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "رفض توثيق الحساب والحوالة",
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                      isUnread: true,
                    ),
                    _SoftDivider(),

                    /// 🔹 2. Approved Investor
                    const _NotificationCard(
                      title: "تم قبول طلبك إلى مستثمر مؤهل",
                      description:
                          "يمكن الإستمتاع بالسقف الإستثماري الجديد والإطلاع على أحدث الفرص",
                    ),
                    _SoftDivider(),

                    /// 🔹 3. Investment Updated
                    _NotificationCard(
                      title: "تم تعديل مبلغ الاستثمار بنجاح",
                      description: "المبلغ الجديد: 1,723.23 ﷼",
                      buttons: [
                        PrimaryTextButton(
                          onTap: () {},
                          label: Text(
                            "استعراض الفرصة",
                            style: context.typography.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget>? buttons;
  final bool isUnread;

  const _NotificationCard({
    required this.title,
    this.description,
    this.buttons,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔔 Bell Icon with background + red dot
          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 6.h),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                /// Light circle background
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: AppColors.blueForeground.withValues(alpha: 0.2),
                    // light blue background
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(IconsConstants.notification),
                    ),
                  ),
                ),

                /// 🔴 Red notification dot
                if (isUnread)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: const BoxDecoration(
                        color: AppColors.errorForeground,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typography.bodyStrongMedium.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
                if (description != null) ...[
                  SizedBox(height: 6.h),
                  Text(
                    description!,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
                      height: 1.5,
                    ),
                  ),
                ],
                if (buttons != null && buttons!.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  Row(children: buttons!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 26.h,
      thickness: 0.6,
      color: AppColors.border_natural_normal.withValues(alpha: 0.6),
    );
  }
}
