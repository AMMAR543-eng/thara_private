import 'package:thara/index/index_main.dart';

class BuildSuccessWidget extends StatefulWidget {
  final InvestmentWizardController controller;
  final bool goToHome;

  const BuildSuccessWidget({
    super.key,
    required this.controller,
    this.goToHome = true,
  });

  @override
  State<BuildSuccessWidget> createState() => _BuildSuccessWidgetState();
}

class _BuildSuccessWidgetState extends State<BuildSuccessWidget> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      if (widget.controller.isEditMode) {
        Get.back();
      } else {
        Get.offAllNamed(mainPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.controller.isEditMode;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          children: [
            Text(
              widget.controller.serverMessage ??
                  (isEdit
                      ? "auto_invest_updated_success".tr
                      : "auto_invest_created_success".tr),
              style: context.typography.headerLarge.copyWith(
                color: AppColors.content_secondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              isEdit ? "redirecting_now".tr : "auto_invest_edit_anytime".tr,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.content_secondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
