import '../../../../index/index_main.dart';

class InvestmentBottomBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onInvestPressed;

  const InvestmentBottomBar({
    super.key,
    required this.controller,
    required this.onInvestPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 12.h),
        color: AppColors.white,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.greyLight.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.right,
                  style: context.typography.font40White.copyWith(
                    color: AppColors.darkJungleGreen,
                  ),
                  decoration: InputDecoration(
                    hintText: "enter_investment_amount".tr,
                    hintStyle: context.typography.font49Grey.copyWith(
                      color: AppColors.greyDark,
                    ),
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(width: 25.w),
            Expanded(
              child: PrimaryTextButton(
                label: Text(
                  "invest".tr,
                  style: context.typography.font49Grey.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: onInvestPressed,
                appButtonSize: AppButtonSize.xxLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
