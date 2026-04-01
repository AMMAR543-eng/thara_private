// build_opportunity_widget.dart
import 'package:thara/index/index_main.dart';

class BuildOpportunityWidget extends StatelessWidget {
  final InvestmentWizardController controller;

  const BuildOpportunityWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final list = controller.data.opportunities ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        children: list.map((op) {
          return SizedBox(
            width: ScreenUtil().screenWidth * 0.28,
            child: SelectableCardWidget(
              selected: op.selected,
              onTap: () => controller.toggleOpportunity(op.id),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // optional icon
                  if (op.icon != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.apartment,
                        size: 28,
                        color: AppColors.primary,
                      ), // replace with svg if available
                    ),
                  Text(
                    op.name,
                    style: context.typography.bodyMedium.copyWith(
                      color: op.selected
                          ? AppColors.primary
                          : AppColors.content_primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
