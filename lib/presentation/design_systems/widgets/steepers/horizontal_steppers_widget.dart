import 'package:flutter/material.dart';

import '../../../../index/index.dart';

class HorizontalStepper extends StatelessWidget {
  final int totalSteps; // عدد الخطوات
  final int currentStep; // الخطوة الحالية
  final Color activeColor;
  final Color inactiveColor;
  final double lineHeight;
  final double circleSize;
  final Duration duration;

  const HorizontalStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor = const Color(0xFF2A8C82),
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.lineHeight = 4,
    this.circleSize = 36,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stepWidth = constraints.maxWidth / (totalSteps - 1);

        return Stack(
          alignment: Alignment.centerRight,
          children: [
            /// --- الخط الرمادي (الخلفية)
            Container(
              height: lineHeight,
              width: constraints.maxWidth,
              color: inactiveColor,
            ),

            /// --- الخط الملون (progress) من مركز لمركز
            AnimatedContainer(
              duration: duration,
              curve: Curves.easeInOutCubic,
              height: lineHeight,
              margin: EdgeInsets.only(left: circleSize / 2),
              width: currentStep == 0 ? 0 : stepWidth * currentStep,
              color: activeColor,
            ),

            /// --- الدواير فوق الخط
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(totalSteps, (index) {
                final isCompleted = index < currentStep;
                final isActive = index == currentStep;

                return TweenAnimationBuilder<double>(
                  duration: duration,
                  tween: Tween<double>(begin: 1.0, end: isActive ? 1.2 : 1.0),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: AnimatedContainer(
                        duration: duration,
                        width: circleSize,
                        height: circleSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted || isActive
                              ? activeColor
                              : inactiveColor,
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: activeColor.withValues(alpha: 0.4),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: isCompleted
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 18,
                                )
                              : isActive
                                  ? Icon(
                                      Icons.circle,
                                      color: AppColors.white,
                                      size: 10,
                                    )
                                  : null,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
