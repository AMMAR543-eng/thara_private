import '../../../../index/index_main.dart';

class ForseItemWidget extends StatelessWidget {
  final bool? from_home;
  final bool? from_all;
  final bool? from_details;
  final OpportunitiesItemsEntity? opportunity;
  final OpportunityDetailsController? opportunityDetailsController;
  final ScrollController? scrollController;

  const ForseItemWidget({
    super.key,
    this.opportunity,
    this.from_home,
    this.from_details,
    this.from_all,
    this.opportunityDetailsController,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final projectName =
        opportunity?.projectName ?? "مشروع شركة كال للتطوير العقاري";
    const projectCode = "TCLC01-502024";
    final interest =
        double.tryParse(
          opportunity?.interestPercentage ?? "",
        )?.toStringAsFixed(0) ??
        "15";
    final riskScore = opportunity?.score ?? "BB";
    final amount =
        opportunity?.principalAmount?.toStringAsFixed(0) ?? "3,000,000";
    final daysLeft = opportunity?.daysToEnd?.toString() ?? "19";
    final percentage =
        opportunity?.collectedPercentage?.toStringAsFixed(0) ?? "100";
    final double fromHomeValue = from_home != null ? 0.85 : 0.8;

    return InkWell(
      onTap: () {
        if (from_details == true) {
          print("donnne");
          opportunityDetailsController?.reloadWithNewId(
            scrollController ?? ScrollController(),
            opportunity?.id ?? "",
          );
        } else {
          Get.to(
            () => OpportunityDetailsView(id: opportunity?.id ?? ""),
            binding: Binding(),
            duration: const Duration(milliseconds: 0),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * fromHomeValue,
        margin: EdgeInsets.only(
          left: from_home != null ? 20 : 3,
          bottom: 20,
          top: 5,
          right: from_all != null ? 20 : 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  child: NetworkAttachmentImage(
                    url: opportunity?.projectImage?[0].url ?? "",
                    height: 350.h,
                    width: MediaQuery.of(context).size.width,
                    boxFit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "$percentage% مكتمل",
                      style: context.typography.font40White.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 20,
                  child: SvgPicture.asset(
                    IconsConstants.arrow,
                    height: 22,
                    width: 22,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "$projectName\n($projectCode)",
                  textAlign: TextAlign.center,
                  style: context.typography.font49Green.copyWith(
                    color: AppColors.darkJungleGreen,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "مبلغ التمويل",
                          textAlign: TextAlign.center,
                          style: context.typography.font40White.copyWith(
                            color: AppColors.darkJungleGreen,
                          ),
                        ),
                        Text(
                          amount,
                          textAlign: TextAlign.center,
                          style: context.typography.font49Green.copyWith(
                            color: AppColors.darkJungleGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(width: 1.5, height: 30, color: Colors.grey[400]),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "تصنيف المخاطر",
                          textAlign: TextAlign.center,
                          style: context.typography.font40White.copyWith(
                            color: AppColors.darkJungleGreen,
                          ),
                        ),
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: AppColors.brass,
                          child: Center(
                            child: Text(
                              riskScore,
                              textAlign: TextAlign.center,
                              style: context.typography.font49Green.copyWith(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(width: 1.5, height: 30, color: Colors.grey[400]),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "معدل المرابحة",
                          textAlign: TextAlign.center,
                          style: context.typography.font40White.copyWith(
                            color: AppColors.darkJungleGreen,
                          ),
                        ),
                        Text(
                          "$interest%",
                          textAlign: TextAlign.center,
                          style: context.typography.font49Green.copyWith(
                            color: AppColors.darkJungleGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 8,
                bottom: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkGray.withAlpha(60),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "متبقي $daysLeft يوم، تم تغطية التمويل $percentage%",
                        textAlign: TextAlign.center,
                        style: context.typography.font49Green.copyWith(
                          color: AppColors.brass,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
