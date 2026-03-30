import 'package:thara/Presentation/screens/opportunity_details/widget/forsa_card_widget.dart';
import '../../design_systems/app_bar/forsa_details_app_bar.dart';
import '../../../index/index_main.dart';
export 'package:share_plus/share_plus.dart';

class OpportunityDetailsView extends StatefulWidget {
  final String? id;

  const OpportunityDetailsView({super.key, this.id});

  @override
  State<OpportunityDetailsView> createState() => _OpportunityDetailsViewState();
}

class _OpportunityDetailsViewState extends State<OpportunityDetailsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = Get.find<OpportunityDetailsController>();
      controller.getOpportunityDetails(widget.id ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GetBuilder<OpportunityDetailsController>(
        init: OpportunityDetailsController(),
        builder: (controller) {
          final opportunity = controller.opportunitiesItemsEntity;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.background_neutral_surface,

            /// ✅ allow resizing when keyboard opens
            appBar: ForsaDetailsAppBar(
              title: opportunity?.projectName ?? "",
              subTitle: opportunity?.id ?? "",
              onBack: () {
                Get.back();
              },
              onShare: () async {
                String title = opportunity?.projectName ?? "";
                String id = opportunity?.id ?? "";
                String url = "https://tharaco.sa/opportunities/$id";
                final message =
                    "💼 ${'discover_investment_opportunity'.tr} $title\n${'share_via_tharaa'.tr} ${url}";
                await Share.share(message);
              },
            ),
            body: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ✅ Reuse the same card (without view button)
                      OpportunityDetailsCardWidget(
                        opportunity:
                            opportunity ?? const OpportunitiesItemsEntity(),
                      ),

                      opportunity?.attachments?.isEmpty == true
                          ? const SizedBox()
                          : InvestmentAgreementCard(
                              controller: controller,
                              opportunity: opportunity,
                            ),

                      AboutOpportunityTab(controller),

                      EfsahWidgetTab(controller),

                      PaymentScheduleWidget(opportunity: opportunity),
                      const SizedBox(height: 15),
                      controller.opportunitiesItemsEntity?.subscriptionStatus !=
                              "subscription_opened"
                          ? const SizedBox()
                          : SubscribeSection(
                              controller: controller,
                              textController: TextEditingController(),
                              opportunityId: opportunity?.id,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
