import '../../../../index/index_main.dart';

class HeaderCard extends StatelessWidget {
  final StatisticsController controller;

  const HeaderCard(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0d2725), Color(0xFF1f3737)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.tradeAccountEntity?.total.toString() ?? "",
                      style: context.typography.montserratBlack62White,
                    ),
                    SvgPicture.asset(
                      IconsConstants.riyal,
                      width: 70.w,
                      height: 70.h,
                      color: AppColors.content_primary,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'total_investments'.tr,
                  style: context.typography.font49Grey.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            IconsConstants.chart_Banner,
            height: 200.h,
            width: 200.w,
          ),
        ],
      ),
    );
  }
}
