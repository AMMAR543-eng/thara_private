import 'package:thara/index/index_main.dart';

class SettingsNotificationView extends StatefulWidget {
  const SettingsNotificationView({super.key});

  @override
  State<SettingsNotificationView> createState() =>
      _SettingsNotificationViewState();
}

class _SettingsNotificationViewState extends State<SettingsNotificationView> {
  bool _projectsEnabled = false;
  bool _transactionsEnabled = false;
  bool _profitsEnabled = false;
  bool _portfolioEnabled = false;
  bool _articlesEnabled = false;
  bool _updatesEnabled = false;
  bool _disableAll = false;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.background_neutral_surface,
      appBar: InnerViewAppBar(title: "manage_notifications".tr),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// --- Notifications List Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildNotificationItem(
                      context,
                      title: "notify_new_projects".tr,
                      value: _projectsEnabled,
                      onChanged: (v) => setState(() => _projectsEnabled = v),
                    ),
                    _divider(),
                    _buildNotificationItem(
                      context,
                      title: "notify_financial_operations".tr,
                      value: _transactionsEnabled,
                      onChanged: (v) =>
                          setState(() => _transactionsEnabled = v),
                    ),
                    _divider(),
                    _buildNotificationItem(
                      context,
                      title: "notify_profit_added".tr,
                      value: _profitsEnabled,
                      onChanged: (v) => setState(() => _profitsEnabled = v),
                    ),
                    _divider(),
                    _buildNotificationItem(
                      context,
                      title: "notify_portfolio_performance".tr,
                      value: _portfolioEnabled,
                      onChanged: (v) => setState(() => _portfolioEnabled = v),
                    ),
                    _divider(),
                    _buildNotificationItem(
                      context,
                      title: "notify_articles_materials".tr,
                      value: _articlesEnabled,
                      onChanged: (v) => setState(() => _articlesEnabled = v),
                    ),
                    _divider(),
                    _buildNotificationItem(
                      context,
                      title: "notify_updates_announcements".tr,
                      value: _updatesEnabled,
                      onChanged: (v) => setState(() => _updatesEnabled = v),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// --- Disable All Notifications Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildNotificationItem(
                  context,
                  title: "disable_all_notifications".tr,
                  value: _disableAll,
                  onChanged: (v) => setState(() => _disableAll = v),
                  isDestructive: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Notification Item Widget
  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isDestructive = false,
  }) {
    final typography = context.typography;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: typography.bodyMedium.copyWith(
                color: isDestructive
                    ? AppColors.errorForeground
                    : AppColors.content_brand_secondary,
                height: 1.4,
              ),
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            inactiveTrackColor: AppColors.border_natural_normal,
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(
        height: 1,
        thickness: 0.8,
        color: AppColors.border_natural_normal,
      );
}
