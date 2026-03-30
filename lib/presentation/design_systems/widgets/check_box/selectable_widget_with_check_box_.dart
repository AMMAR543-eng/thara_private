import 'package:thara/Presentation/design_systems/widgets/check_box/selectable_card_check_box_widget.dart';
import 'package:thara/index/index_main.dart';

class SelectableWidgetWithCheckBox extends StatelessWidget {
  final String title;
  final List<SelectableCardCheckBoxWidget> options;

  const SelectableWidgetWithCheckBox({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ عنوان القسم
        Text(
          title,
          style: context.typography.bodyLarge.copyWith(
            color: AppColors.primary,
          ),
        ),

        // ✅ الكروت
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: options.map((option) => Expanded(child: option)).expand((
              widget,
            ) sync* {
              yield widget;
              if (widget != options.last) yield SizedBox(width: 15.w);
            }).toList(),
          ),
        ),
      ],
    );
  }
}
