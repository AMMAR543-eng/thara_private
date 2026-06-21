import '../../../index/index_main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DashboardController controller = initUseCase(
    () => DashboardController(),
  );

  @override
  void initState() {
    super.initState();
    _checkAndShowBottomSheet();
  }

  /// ✅ Checks if the bottom sheet should be shown (only once ever)
  Future<void> _checkAndShowBottomSheet() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool('hasShownStartInvestmentSheet') ?? false;

    if (!hasShown) {
      // Wait for data to be ready (after controller fetch)
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted &&
            controller.tradeAccountEntity != null &&
            (controller.tradeAccountEntity?.total ?? 0) == 0) {
          _showStartInvestmentSheet();

          // ✅ Save flag so we don’t show again
          prefs.setBool('hasShownStartInvestmentSheet', true);
        }
      });
    }
  }

  void _showStartInvestmentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const StartInvestmentBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.background_neutral_surface,
        appBar: HomeAppBar(title: "home".tr),
        body: GetBuilder<DashboardController>(
          builder: (controller) {
            final token =
                LoginResponseModel().getTokenData()?.data?.accessToken;
            final trade = controller.tradeAccountEntity;
            final hasDeposit = (trade?.total ?? 0) > 0;
            final noDeposit = trade != null && (trade.total ?? 0) == 0;
            final isGuest = token == null;

            if (controller.isLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (_, __) => const ForseItemShimmerWidget(),
                ),
              );
            }

            return Stack(
              children: [
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
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (isGuest) ...[
                          _buildHeaderRow(context, controller),
                          _buildOpportunitiesList(context, controller),
                        ] else if (noDeposit) ...[
                          HomeInvestCreditTopWidget(
                            balance: controller.tradeAccountEntity?.total
                                ?.toDouble(),
                          ),
                          _buildHeaderRow(context, controller),
                          _buildOpportunitiesList(context, controller),
                          controller.investmentConfigResponseModel?.data
                                      ?.configured ==
                                  false
                              ? PrimaryTextButton(
                                  label: Text(
                                    "activate_auto_invest".tr, // ← 🔥 معرّب
                                    style: context.typography.bodyLarge
                                        .copyWith(color: AppColors.white),
                                  ),
                                  onTap: () {
                                    Get.to(
                                      () => const InvestmentOnboardingScreen(),
                                    );
                                  },
                                )
                              : PrimaryTextButton(
                                  label: Text(
                                    "edit_auto_invest_preferences".tr,
                                    // ← 🔥 معرّب
                                    style: context.typography.bodyLarge
                                        .copyWith(color: AppColors.white),
                                  ),
                                  onTap: () {
                                    final config = controller
                                        .investmentConfigResponseModel
                                        ?.data
                                        ?.config;

                                    if (config != null) {
                                      final entity = controller
                                          .mapConfigToWizardEntity(config);

                                      /// 🔥 افتح البوتوم شيت مع البيانات
                                      showInvestSettingsSheet(
                                        Get.context!,
                                        entity,
                                      );
                                    }
                                  },
                                ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: InvestmentSummaryWidget(),
                          ),
                          RepaintBoundary(
                            child: ProfitChartWidget(
                              profitSummaryDataModel:
                                  controller.monthlyProfitData,
                            ),
                          ),
                        ] else if (hasDeposit) ...[
                          HomeInvestCreditTopWidget(
                            balance: controller.tradeAccountEntity?.total
                                ?.toDouble(),
                          ),
                          StartInvestWithBalance(controller: controller),
                          controller.investmentConfigResponseModel?.data
                                      ?.configured ==
                                  false
                              ? PrimaryTextButton(
                                  label: Text(
                                    "activate_auto_invest".tr, // ← 🔥 معرّب
                                    style: context.typography.bodyLarge
                                        .copyWith(color: AppColors.white),
                                  ),
                                  onTap: () {
                                    Get.to(
                                      () => const InvestmentOnboardingScreen(),
                                    );
                                  },
                                )
                              : PrimaryTextButton(
                                  label: Text(
                                    "edit_auto_invest_preferences".tr,
                                    // ← 🔥 معرّب
                                    style: context.typography.bodyLarge
                                        .copyWith(color: AppColors.white),
                                  ),
                                  onTap: () {
                                    final config = controller
                                        .investmentConfigResponseModel
                                        ?.data
                                        ?.config;

                                    if (config != null) {
                                      final entity = controller
                                          .mapConfigToWizardEntity(config);

                                      /// 🔥 افتح البوتوم شيت مع البيانات
                                      showInvestSettingsSheet(
                                        Get.context!,
                                        entity,
                                      );
                                    }
                                  },
                                ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 15),
                            child: InvestmentSummaryWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: ProfitChartWidget(
                              profitSummaryDataModel:
                                  controller.monthlyProfitData,
                            ),
                          ),
                          _buildHeaderRow(context, controller),
                          _buildOpportunitiesList(context, controller),
                          controller.isWaitingProfessional == true
                              ? const WaitingQualifiedInvestorWidget()
                              : controller.isProfessional == true
                                  ? const ProfessionalInvestorWidget()
                                  : const UpgradeQualifiedInvestorWidget(),
                          const InvestmentTransactionsWidget(),
                        ],
                      ],
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

  /// 🔹 Header Row
  Widget _buildHeaderRow(BuildContext context, DashboardController controller) {
    final hasDeposit = (controller.tradeAccountEntity?.total ?? 0) > 0;
    return Padding(
      padding: EdgeInsets.only(top: 10.0.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              !hasDeposit
                  ? "start_first_investment".tr
                  : "new_opportunities".tr,
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
    );
  }

  /// 🔹 Opportunities List
  Widget _buildOpportunitiesList(
    BuildContext context,
    DashboardController controller,
  ) {
    final hasDeposit = (controller.tradeAccountEntity?.total ?? 0) > 0;
    final opportunities =
        controller.upcomingOpportunities?.opportunitiesItems ?? [];

    if (opportunities.isEmpty) {
      return Container(
        height: hasDeposit
            ? MediaQuery.of(context).size.height * 0.20
            : MediaQuery.of(context).size.height * 0.48,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "no_opportunities_available".tr,
              style: context.typography.bodyLarge.copyWith(
                color: AppColors.action_primary_normal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),
            Text(
              "new_opportunities_soon".tr,
              style: context.typography.bodySmall.copyWith(
                color: AppColors.action_primary_normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: hasDeposit
          ? MediaQuery.of(context).size.height * 0.57
          : MediaQuery.of(context).size.height * 0.48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: opportunities.length,
        itemBuilder: (context, index) {
          final item = opportunities[index];
          return RepaintBoundary(
            child: OpportunityCardWidget(
              opportunity: item ?? const OpportunitiesItemsEntity(),
              onTap: () {
                Get.to(
                  () => OpportunityDetailsView(id: item?.id ?? ""),
                  binding: Binding(),
                  duration: const Duration(milliseconds: 0),
                );
              },
              show_view_button: hasDeposit,
            ),
          );
        },
      ),
    );
  }
}
