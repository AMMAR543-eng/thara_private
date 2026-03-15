import 'package:thara/Presentation/screens/dashboard/all_forsa/all_forsa.dart';
import 'package:thara/Presentation/screens/dashboard/widget_new_ui%20/start_invest_forsa_card_widget.dart';
import '../../../../index/index_main.dart';

class StartInvestWithBalance extends StatelessWidget {
  final DashboardController controller;

  const StartInvestWithBalance({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final opportunities = controller.availableOpportunities?.opportunitiesItems;

    final bool isLoading = controller.availableOpportunities == null;
    final bool isEmpty = opportunities != null && opportunities.isEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.0.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "start_first_investment".tr,
                  style: context.typography.headerXLarge.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => const AllForsa(isShowForsa: true),
                    binding: Binding(),
                  );
                },
                child: Text(
                  "view_all".tr,
                  style: context.typography.bodyStrongMedium.copyWith(
                    color: AppColors.action_primary_normal,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                LocalStorage_language().read() == "ar"
                    ? IconsConstants.forward_arrow
                    : IconsConstants.back,
                width: 15,
                height: 15,
                color: AppColors.action_primary_normal,
              ),
            ],
          ),
        ),

        /// 🔹 Opportunities List / Shimmer / Empty Placeholder
        Container(
          padding: EdgeInsets.only(top: 6.h),
          height: MediaQuery.of(context).size.height * 0.32,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, __) => const ForseItemShimmerWidget(),
                )
              : isEmpty
              ? Center(
                  child: Text(
                    "no_opportunities_available".tr,
                    style: context.typography.bodyStrongMedium.copyWith(
                      color: AppColors.action_primary_normal,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: opportunities?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = opportunities![index];

                    return OpportunityCardAltWidget(
                      opportunity: item ?? const OpportunitiesItemsEntity(),
                      onTap: () {
                        Get.to(
                          () => OpportunityDetailsView(id: item?.id ?? ""),
                          binding: Binding(),
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
