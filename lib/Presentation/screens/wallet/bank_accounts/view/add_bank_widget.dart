import '../../../../../index/index_main.dart';

class AddBankAccountCardWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AddBankAccountCardWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180.w,
        margin: EdgeInsets.only(left: 0.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.border_default,
            width: 0.4,
            style: BorderStyle.solid,
          ),
        ),
        child: DottedBorderContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primary, size: 30),
              SizedBox(height: 10.h),
              Text(
                "add_bank_account".tr,
                textAlign: TextAlign.center,
                style: typography.bodyStrongMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Helper widget to create a dotted outline effect
class DottedBorderContainer extends StatelessWidget {
  final Widget child;

  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return CustomPaint(
          painter: _DottedBorderPainter(),
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }
}

/// Custom painter for dotted border
class _DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border_default
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
