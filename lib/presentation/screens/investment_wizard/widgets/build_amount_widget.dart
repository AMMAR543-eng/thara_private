import 'package:thara/index/index_main.dart';

class BuildAmountWidget extends StatelessWidget {
  final InvestmentWizardController controller;
  final GlobalKey<FormState> formKey;
  final HandleKeyboardService keyboardService;
  final List<String> keys;

  const BuildAmountWidget({
    super.key,
    required this.controller,
    required this.formKey,
    required this.keyboardService,
    required this.keys,
  });

  // ---------------- VALIDATORS WITH LOCALIZATION ----------------

  String? _validateMin(String? val) {
    if (val == null || val.trim().isEmpty) {
      return "min_required".tr; // يجب إدخال حد أدنى.
    }

    final n = int.tryParse(val);
    if (n == null) return "value_invalid".tr;

    if (n <= 0) return "value_must_be_positive".tr;

    if (n < 1000) return "min_must_be_1000_or_more".tr;

    return null;
  }

  String? _validateMax(String? val) {
    if (val == null || val.trim().isEmpty) return "max_required".tr;

    final n = int.tryParse(val);
    if (n == null) return "value_invalid".tr;

    if (n <= 0) return "value_must_be_positive".tr;

    if (n % 1000 != 0) return "must_be_multiple_of_1000".tr;

    final minVal = int.tryParse(controller.minController.text) ?? 0;
    if (n < minVal)
      return "max_must_be_more_than_min".trParams({
        "min": "$minVal",
      });

    return null;
  }

  // ---------------- BUILD UI ----------------

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextInputWidget(
              title: "min_invest_title".tr, // الحد الأدنى للاستثمار
              appTextField: AppTextField(
                controller: controller.minController,
                hintText: "0",
                focusNode: keyboardService.getFocusNode(keys[0]),
                keyboardType: TextInputType.number,
                validator: _validateMin,
                onChanged: (_) => controller.update(),
              ),
            ),
            SizedBox(height: 20.h),
            TextInputWidget(
              title: "max_invest_title".tr, // الحد الأعلى للاستثمار
              appTextField: AppTextField(
                controller: controller.maxController,
                hintText: "0",
                focusNode: keyboardService.getFocusNode(keys[1]),
                keyboardType: TextInputType.number,
                validator: _validateMax,
                onChanged: (_) => controller.update(),
              ),
            ),
            if (controller.serverMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  controller.serverMessage!,
                  style: context.typography.bodySmall.copyWith(
                    color: AppColors.errorForeground,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
