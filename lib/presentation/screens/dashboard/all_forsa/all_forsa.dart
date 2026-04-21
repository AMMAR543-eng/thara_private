import 'package:thara/Presentation/screens/dashboard/all_forsa/custom_app_bar_all_forsa.dart';
import '../../../../index/index_main.dart';
import '../../../design_systems/widgets/pagination/pagination_list_widget.dart';
import '../../../design_systems/widgets/pagination/widget/pagination_loader.dart';
import '../../../design_systems/widgets/pagination/widget/shimmer_loader_deals.dart';

class AllForsa extends StatefulWidget {
  final bool? isShowForsa;

  const AllForsa({super.key, this.isShowForsa});

  @override
  State<AllForsa> createState() => _AllForsaState();
}

class _AllForsaState extends State<AllForsa> {
  final OpportunitiesController dashboardController = initUseCase(
    () => OpportunitiesController(),
  );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background_neutral_surface,
        appBar: AllForsaAppBar(
          title: 'all_investment_opportunities'.tr,
          controller: dashboardController,
          showBackAndLimitedUI: widget.isShowForsa,
        ),
        body: GetBuilder<OpportunitiesController>(
          init: OpportunitiesController(),
          builder: (controller) {
            /// ✅ Initial loading (same mindset as HomeView)
            if (controller.opportunities == null &&
                controller.paginationHandleClass.items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                /// 🔹 Background pattern
                Positioned(
                  left: -150,
                  top: 20,
                  child: Image.asset(
                    Images.home_pattern,
                    width: ScreenUtil().screenWidth,
                    height: 400,
                    fit: BoxFit.fill,
                    color: AppColors.focus_input_text.withValues(alpha: 0.07),
                  ),
                ),

                /// 🔹 Content
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: PaginatedListView<OpportunitiesItemsEntity?>(
                      controller: controller.paginationHandleClass,
                      shimmerLoader: const ShimmerLoaderDeals(),
                      paginationLoader: const PaginationLoader(),
                      itemBuilder: (context, item, index) {
                        final opportunity =
                            controller.paginationHandleClass.items[index];

                        return OpportunityCardWidget(
                          opportunity:
                              opportunity ?? const OpportunitiesItemsEntity(),
                          onTap: () {
                            Get.to(
                              () => OpportunityDetailsView(id: opportunity?.id),
                              binding: Binding(),
                              duration: const Duration(milliseconds: 0),
                            );
                          },
                          tab_index: controller.tab_index,
                          show_view_button: true,
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
