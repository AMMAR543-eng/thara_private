import 'package:flutter/material.dart';
import 'package:thara/Presentation/design_systems/widgets/check_box/check_box_widget.dart';

class DoubleBorderCheckbox extends StatelessWidget {
  final bool isSelected;
  final double outerSize;
  final double outerBorderWidth;
  final double borderRadius;
  final Color outerSelectedColor;
  final Color outerUnselectedColor;

  // Inner box props
  final double innerSize;
  final double innerBorderWidth;
  final Color innerSelectedColor;
  final Color innerBorderColor;
  final Color checkColor;

  const DoubleBorderCheckbox({
    super.key,
    required this.isSelected,
    this.outerSize = 30,
    this.outerBorderWidth = 4,
    this.borderRadius = 8,
    required this.outerSelectedColor,
    required this.outerUnselectedColor,
    this.innerSize = 26,
    this.innerBorderWidth = 2,
    required this.innerSelectedColor,
    required this.innerBorderColor,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ✅ Outer Border
        Container(
          width: outerSize,
          height: outerSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: isSelected ? outerSelectedColor : outerUnselectedColor,
              width: outerBorderWidth,
            ),
          ),
        ),

        // ✅ Reused Inner Box
        InnerCheckboxBox(
          isSelected: isSelected,
          size: innerSize,
          borderWidth: innerBorderWidth,
          borderRadius: borderRadius - 2,
          selectedColor: innerSelectedColor,
          borderColor: innerBorderColor,
          checkColor: checkColor,
        ),
      ],
    );
  }
}
