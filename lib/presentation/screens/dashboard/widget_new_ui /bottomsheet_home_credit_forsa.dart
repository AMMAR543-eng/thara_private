import '../../../../index/index_main.dart';

class StartInvestmentBottomSheet extends StatelessWidget {
  const StartInvestmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        color: AppColors.white,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16, top: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            /// 🔹 Title
            Text(
              "one_step_away_from_investment".tr,
              style: context.typography.headerXLarge.copyWith(
                color: AppColors.content_primary,
              ),
            ),

            const SizedBox(height: 3),

            /// 🔹 Description
            Text(
              "please_add_balance_to_start_investment".tr,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            /// 🔹 Add Balance Button
            SizedBox(
              width: ScreenUtil().screenWidth - 50.w,
              child: PrimaryTextButton(
                label: Text(
                  "add_balance".tr,
                  style: context.typography.bodyLarge.copyWith(),
                ),
                onTap: () {
                  Get.offAll(() => MainPage(indexNum: 3), binding: Binding());
                  Get.back();
                },
              ),
            ),

            const SizedBox(height: 12),

            /// 🔹 View Opportunities Button
            SizedBox(
              width: ScreenUtil().screenWidth - 50.w,
              child: PrimaryTextButton(
                customBackgroundColor: AppColors.white,
                customBorder: const BorderSide(
                  color: AppColors.border_natural_normal,
                  width: 1,
                ),
                label: Text(
                  "view_all_opportunities".tr,
                  style: context.typography.bodyLarge.copyWith(
                    color: AppColors.action_natural_normal,
                  ),
                ),
                onTap: () {
                  Get.back();
                  Get.offAll(() => MainPage(indexNum: 1), binding: Binding());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
