import 'package:flutter/material.dart';

class InnerCheckboxBox extends StatelessWidget {
  final bool isSelected;
  final double size;
  final double borderWidth;
  final double borderRadius;
  final Color selectedColor;
  final Color borderColor;
  final Color checkColor;

  const InnerCheckboxBox({
    super.key,
    required this.isSelected,
    this.size = 26,
    this.borderWidth = 2,
    this.borderRadius = 6,
    required this.selectedColor,
    required this.borderColor,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isSelected ? borderColor : Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: size * 0.7, color: checkColor)
          : null,
    );
  }
}
