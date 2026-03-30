import '../../../../index/index_main.dart';

class ProgressWidget extends StatelessWidget {
  final OpportunityDetailsController controller;

  const ProgressWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0d2725), Color(0xFF1f3737)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 90.r,
                        height: 90.r,
                        child: CircularProgressIndicator(
                          value: (controller.opportunitiesItemsEntity?.collectedPercentage ?? 0) / 100,
                          strokeWidth: 3,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.greyDark,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${controller.opportunitiesItemsEntity?.collectedPercentage}%\n',
                              style: context.typography.bodyMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            TextSpan(
                              text: 'covered'.tr,
                              style: context.typography.bodySmall.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Icon(Icons.hourglass_bottom, color: AppColors.white),
                        SizedBox(height: 8.h),
                        Text(
                          "${'remaining_days'.tr} ${controller.opportunitiesItemsEntity?.daysToEnd} ${'days'.tr}",
                          style: context.typography.bodyMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                          child: Divider(thickness: 0.2),
                        ),
                        Text(
                          "${'minimum_investment'.tr} ${controller.opportunitiesItemsEntity?.sharePrice} ${'currency_sar'.tr}",
                          style: context.typography.bodySmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
