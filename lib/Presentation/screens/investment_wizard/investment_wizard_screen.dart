import 'package:thara/index/index_main.dart';

class InvestmentWizardScreen extends StatefulWidget {
  final InvestmentWizardEntity? editData; // pass to open in edit mode

  const InvestmentWizardScreen({super.key, this.editData});

  @override
  State<InvestmentWizardScreen> createState() => _InvestmentWizardScreenState();
}

class _InvestmentWizardScreenState extends State<InvestmentWizardScreen> {
  late InvestmentWizardController controller;
  final _formAmountKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = InvestmentWizardController();
    if (widget.editData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.loadForEdit(widget.editData!);
      });
    }
    super.initState();
  }

  Widget _buildStepContent(
    final HandleKeyboardService keyboardService,
    // ⬅️ جديد
    final List<String> keys,
  ) {
    switch (controller.currentStep) {
      case 0:
        return BuildOpportunityWidget(controller: controller);
      case 1:
        return BuildAmountWidget(
          controller: controller,
          formKey: _formAmountKey,
          keyboardService: keyboardService,
          keys: keys,
        );
      case 2:
        return BuildPackageWidget(controller: controller);
      case 3:
        return BuildDurationWidget(controller: controller);
      case 4:
        return BuildSuccessWidget(controller: controller);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardService = HandleKeyboardService();
    final keys = keyboardService.generateKeys(
      "invest_wizard",
      2,
    ); // Step 1 has 2 fields

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // 🔥 مهم جداً
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "wizard_title".tr,
          style: context.typography.bodyLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),

      bottomNavigationBar: GetBuilder<InvestmentWizardController>(
        init: controller,
        builder: (c) {
          if (c.currentStep == 4) return const SizedBox.shrink();

          bool enabled = c.isStepValid(c.currentStep);

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grayMedium.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  if (c.currentStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: PressAnimatedButton(
                          backgroundColor: AppColors.grayLight,
                          borderRadius: BorderRadius.circular(12),
                          label: Text(
                            "back".tr,
                            style: context.typography.bodyMedium,
                          ),
                          onTap: enabled ? c.prevStep : null,
                        ),
                      ),
                    ),
                  if (c.currentStep > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 52.h,
                      child: PressAnimatedButton(
                        backgroundColor: enabled
                            ? AppColors.primary_normal
                            : AppColors.primary_normal.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        enabled: enabled,
                        label: Text(
                          "confirm".tr,
                          style: context.typography.bodyLarge.copyWith(
                            color: enabled
                                ? AppColors.white
                                : AppColors.white.withOpacity(0.5),
                          ),
                        ),
                        onTap: enabled
                            ? () async {
                                if (c.currentStep == 1) {
                                  final valid =
                                      _formAmountKey.currentState?.validate() ??
                                      false;
                                  if (!valid) return;
                                }
                                if (c.currentStep < 3) {
                                  c.nextStep();
                                } else {
                                  await c.submit();
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: GetBuilder<InvestmentWizardController>(
        init: controller,
        builder: (c) {
          return KeyboardActions(
            config: keyboardService.buildConfig(context, keys),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top tabs (visual steps)
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 15.h,
                      left: 20.h,
                      right: 20.h,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildTopTab("wizard_step_0".tr, 0, c),
                          const SizedBox(width: 16),
                          _buildTopTab("wizard_step_1".tr, 1, c),
                          const SizedBox(width: 16),
                          _buildTopTab("wizard_step_2".tr, 2, c),
                          const SizedBox(width: 16),
                          _buildTopTab("wizard_step_3".tr, 3, c),
                        ],
                      ),
                    ),
                  ),

                  // content card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderNeutralPrimary),
                    ),
                    child: Column(
                      children: [
                        // Title / right-column area
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getTitleOfStep(c.currentStep),
                                    style: context.typography.headerLarge
                                        .copyWith(
                                          color:
                                              AppColors.content_brand_secondary,
                                        ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _getSubtitleOfStep(c.currentStep),
                                    style: context.typography.bodyMedium
                                        .copyWith(
                                          color: AppColors.content_secondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            // right side: space for confirm button if desired
                          ],
                        ),

                        const SizedBox(height: 18),

                        // dynamic step content
                        _buildStepContent(keyboardService, keys),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopTab(
    String title,
    int stepIndex,
    InvestmentWizardController c,
  ) {
    final active = c.currentStep == stepIndex;
    return InkWell(
      onTap: () => c.goToStep(stepIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary.withValues(alpha: 0.06) : null,
          borderRadius: BorderRadius.circular(6),
          border: active
              ?  Border(
                  bottom: BorderSide(width: 3, color: AppColors.primary),
                )
              : null,
        ),
        child: Text(
          title,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.content_primary,
          ),
        ),
      ),
    );
  }

  String _getTitleOfStep(int step) {
    switch (step) {
      case 0:
        return "wizard_step_0".tr;
      case 1:
        return "wizard_step_1".tr;
      case 2:
        return "wizard_step_2".tr;
      case 3:
        return "wizard_step_3".tr;
      case 4:
        return "";
      default:
        return "";
    }
  }


  String _getSubtitleOfStep(int step) {
    switch (step) {
      case 0:
        return "wizard_subtitle_multi_select".tr;
      case 1:
        return "";
      case 2:
        return "wizard_subtitle_multi_select".tr;
      case 3:
        return "wizard_subtitle_multi_select".tr;
      default:
        return "";
    }
  }

}
