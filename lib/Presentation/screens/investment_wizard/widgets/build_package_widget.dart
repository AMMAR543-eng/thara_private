// build_package_widget.dart
import 'package:thara/index/index_main.dart';

class BuildPackageWidget extends StatelessWidget {
  final InvestmentWizardController controller;

  const BuildPackageWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final list = controller.data.packages ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      child: Column(
        spacing: 16,
        children: list.map((p) {
          return SizedBox(
            width: ScreenUtil().screenWidth * 0.70,
            child: SelectableCardWidget(
              selected: p.selected,
              onTap: () => controller.togglePackage(p.id),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    p.title,
                    style: context.typography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.content_secondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p.description,
                    style: context.typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
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
