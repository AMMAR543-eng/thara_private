import '../../../../index/index_main.dart';

void showRiskDisclaimerBottomSheet(
    BuildContext context, {
      required OpportunityDetailsController controller,
      required String? opportunityId,
      required String textController,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>  _RiskDisclaimerContent(amount: textController,),
  );
}

class _RiskDisclaimerContent extends StatelessWidget {
  const _RiskDisclaimerContent({super.key,required this.amount});
  final String amount;

  @override
  Widget build(BuildContext context) {
    final OpportunityDetailsController controller =
    Get.find<OpportunityDetailsController>();
    final sharePrice = controller.opportunitiesItemsEntity?.sharePrice;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Top drag handle
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),

              /// 🔹 Header (icon + title)
              Row(
                children: [
                  const Icon(
                    Icons.info_rounded,
                    color: AppColors.blueForeground,
                    size: 30,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "risk_disclaimer".tr,
                    style: context.typography.headerXLarge.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              /// 🔹 Description
              Text(
                "risk_disclaimer_description".tr,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.tertiary,
                ),
                textAlign: TextAlign.justify,
              ),

              SizedBox(height: 28.h),

              /// 🔹 Action Buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// Cancel Button
                  SizedBox(
                    height: 50.h,
                    child: PrimaryTextButton(
                      customBackgroundColor: AppColors.white,
                      customBorder: BorderSide(
                        color: AppColors.border_natural_normal,
                        width: 1,
                      ),
                      label: Text(
                        "cancel".tr,
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () => Navigator.pop(context),
                      appButtonSize: AppButtonSize.xxLarge,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// Confirm Button
                  SizedBox(
                    height: 50.h,
                    child: PrimaryTextButton(
                      label: Text(
                        "confirm".tr,
                        style: context.typography.bodyMedium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        print(" textController is ${amount}");
                        Navigator.pop(context);
                        controller.subscribeToLoan(
                          controller.opportunitiesItemsEntity?.id ?? "",
                          sharePrice?.toInt() ?? 0,
                          amount,
                        );
                      },
                      appButtonSize: AppButtonSize.xxLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
