// build_duration_widget.dart
import 'package:thara/index/index_main.dart';

class BuildDurationWidget extends StatelessWidget {
  final InvestmentWizardController controller;

  const BuildDurationWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final list = controller.data.durations ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Column(
        children: list.map((d) {
          return SizedBox(
            width: ScreenUtil().screenWidth * 0.28,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SelectableCardWidget(
                selected: d.selected,
                onTap: () => controller.toggleDuration(d.id),
                child: Text(
                  d.title,
                  style: context.typography.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: d.selected
                        ? AppColors.primary
                        : AppColors.content_primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
