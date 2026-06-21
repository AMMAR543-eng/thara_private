import 'package:thara/index/index_main.dart';

class AllInvestmentsView extends StatelessWidget {
  const AllInvestmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "your_investment_summary".tr, // 🔁 "ملخص استثماراتك"
          style: context.typography.font52Grey.copyWith(
            color: AppColors.background_black,
          ),
        ),
      ),
      body: GetBuilder<StatisticsController>(
        init: StatisticsController(),
        builder: (controller) {
          return controller.investmentItems.isEmpty
              ? PlaceholderImage(
                  image: Images.no_data,
                  messege: "no_data".tr, // 🔁 "لا توجد بيانات"
                  isAsset: true,
                )
              : ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.investmentItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.investmentItems[index];

                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => OpportunityDetailsView(
                              id: item.opportunityId ?? ""),
                          binding: Binding(),
                          duration: const Duration(milliseconds: 0),
                        );
                      },
                      child: InvestmentItem(
                        title: item.projectName ??
                            'no_name'.tr, // 🔁 fallback "بدون اسم"
                        statusLabel: mapStatusToLabel(item.status),
                        statusColor: mapStatusToColor(item.status),
                        statusTextColor: mapStatusTextColor(item.status),
                        investmentAmount: item.totalPrice.toString(),
                        date: item.createdAt ?? '',
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
