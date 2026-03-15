// selectable_card_widget.dart
import 'package:thara/index/index_main.dart';

class SelectableCardWidget extends StatelessWidget {
  final Widget child;
  final bool selected;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const SelectableCardWidget({
    super.key,
    required this.child,
    this.selected = false,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.05) : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.borderNeutralPrimary,
            width: 0.8,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
