import 'package:thara/Presentation/design_systems/widgets/guest/guest_user_widget.dart';
import 'package:thara/Presentation/screens/statisctics/shimmer_list.dart';
import 'package:thara/Presentation/screens/statisctics/widgets/status_card_widget.dart';
import 'package:thara/Presentation/screens/statisctics/widgets/total_invest_widget.dart';
import '../../../index/index_main.dart';

class StatiscticsView extends StatelessWidget {
  const StatiscticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsController>(
      init: StatisticsController(),
      builder: (controller) {
        final isGuest =
            LoginResponseModel().getTokenData()?.data?.accessToken == null;
        print("isGuest is ${isGuest}");

        return Directionality(
          textDirection: TextDirection.rtl,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: SafeArea(
                child: Stack(
                  children: [
                    /// 🔹 Pattern Background (Optional aesthetic, similar to ProcessView)
                    Positioned(
                      left: -150,
                      top: 20,
                      child: Image.asset(
                        Images.home_pattern,
                        width: ScreenUtil().screenWidth,
                        height: 400.h,
                        fit: BoxFit.fill,
                        color: AppColors.focus_input_text.withValues(
                          alpha: 0.07,
                        ),
                      ),
                    ),

                    /// 🔹 Main Content
                    isGuest
                        ? const GuestUserDialogWidget()
                        : _buildStatisticsContent(context, controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Logged-in User Statistics Content
  Widget _buildStatisticsContent(
    BuildContext context,
    StatisticsController controller,
  ) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      children: [
        HeaderCard(controller),

        /// 🔹 Status Cards Row
        Container(
          margin: EdgeInsets.symmetric(vertical: 50.h),
          height: 450.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 300.w,
                child: StatusCard(
                  amount:
                      controller.tradeAccountEntity?.reserved?.toString() ?? "",
                  label: 'reserved_cash'.tr,
                  color: AppColors.moonstoneBlue.withOpacity(0.15),
                  amountColor: AppColors.moonstoneBlue,
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 300.w,
                child: StatusCard(
                  amount:
                      controller.tradeAccountEntity?.expectedProfit
                          ?.toString() ??
                      "",
                  label: 'collected_profits'.tr,
                  color: const Color(0xFFFEF8E6).withOpacity(0.8),
                  amountColor: const Color(0xFFBB9C24),
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 300.w,
                child: StatusCard(
                  amount:
                      controller.tradeAccountEntity?.invested?.toString() ?? "",
                  label: 'active_investments'.tr,
                  color: AppColors.blueLightBackground.withValues(alpha: 0.4),
                  amountColor: AppColors.moonstoneBlue,
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                width: 300.w,
                child: StatusCard(
                  amount:
                      controller.tradeAccountEntity?.expectedProfit
                          ?.toString() ??
                      "",
                  label: 'expected_total_profit'.tr,
                  color: AppColors.fawn.withOpacity(0.15),
                  amountColor: const Color(0xFFBB9C24),
                ),
              ),
            ],
          ),
        ),

        /// 🔹 Investment Summary Section
        Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 10.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'investment_summary'.tr,
                style: context.typography.font42Grey.copyWith(
                  color: AppColors.greyDark,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(allInvestementsView),
                child: Text(
                  'view_all'.tr,
                  style: context.typography.font33Grey,
                ),
              ),
            ],
          ),
        ),

        /// 🔹 Investments List or Shimmer
        controller.investmentEntity?.items == null
            ? ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 20.h),
                itemBuilder: (_, __) => const InvestmentShimmerItem(),
              )
            : controller.investmentEntity?.items?.isEmpty == true
            ? Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: PlaceholderImage(
                  image: Images.no_data,
                  messege: "no_data".tr,
                  isAsset: true,
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 20.h),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.investmentItems.length,
                itemBuilder: (context, index) {
                  final item = controller.investmentItems[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => OpportunityDetailsView(
                          id: item.opportunityId ?? "",
                        ),
                        binding: Binding(),
                        duration: const Duration(milliseconds: 0),
                      );
                    },
                    child: InvestmentItem(
                      title: item.projectName ?? 'no_name'.tr,
                      statusLabel: mapStatusToLabel(item.status),
                      statusColor: mapStatusToColor(item.status),
                      statusTextColor: mapStatusTextColor(item.status),
                      investmentAmount: item.totalPrice.toString(),
                      date: item.createdAt ?? '',
                    ),
                  );
                },
              ),
      ],
    );
  }
}

/// --- Status label mapping helpers
String mapStatusToLabel(String? status) {
  switch (status) {
    case 'active':
      return 'status_active'.tr;
    case 'closed':
      return 'status_closed'.tr;
    case 'on_hold':
      return 'status_on_hold'.tr;
    case 'canceled':
      return 'status_canceled'.tr;
    default:
      return 'status_unknown'.tr;
  }
}

Color mapStatusToColor(String? status) {
  switch (status) {
    case 'active':
      return AppColors.successBackground;
    case 'closed':
      return AppColors.grayLight;
    case 'on_hold':
      return AppColors.tag_icon_warning;
    case 'canceled':
      return AppColors.errorBackground;
    default:
      return AppColors.borderNeutralPrimary;
  }
}

Color mapStatusTextColor(String? status) {
  switch (status) {
    case 'active':
      return AppColors.successForeground;
    case 'closed':
      return AppColors.greyDark;
    case 'on_hold':
      return AppColors.tag_icon_warning;
    case 'canceled':
      return AppColors.errorForeground;
    default:
      return AppColors.greyDark;
  }
}

/// --- Investment item widget
class InvestmentItem extends StatelessWidget {
  final String title;
  final String statusLabel;
  final Color statusColor;
  final Color statusTextColor;
  final String date;
  final String investmentAmount;

  const InvestmentItem({
    super.key,
    required this.title,
    required this.statusLabel,
    required this.statusColor,
    required this.statusTextColor,
    required this.date,
    required this.investmentAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.h),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: AppColors.borderNeutralPrimary, width: 0.4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconsConstants.file,
            width: 60.w,
            height: 60.h,
            color: AppColors.primary,
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.typography.font44White.copyWith(
                    color: AppColors.background_black,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "$investmentAmount ر.س",
                  style: context.typography.font33Grey.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  date,
                  style: context.typography.font33Grey.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              statusLabel,
              style: context.typography.font33Grey.copyWith(
                color: statusTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
