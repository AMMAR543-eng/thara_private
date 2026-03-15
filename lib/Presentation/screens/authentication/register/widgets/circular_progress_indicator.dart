import 'dart:math';
import '../../../../../index/index_main.dart';

class CircularProgressIndicatorWidget extends StatefulWidget {
  final int maxProgress;
  final bool isAnimating;
  final String code;

  const CircularProgressIndicatorWidget({
    super.key,
    required this.maxProgress,
    required this.isAnimating,
    required this.code,
  });

  @override
  State<CircularProgressIndicatorWidget> createState() =>
      _CircularProgressIndicatorWidgetState();
}

class _CircularProgressIndicatorWidgetState
    extends State<CircularProgressIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.maxProgress.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        final progress = widget.isAnimating
            ? _progressAnimation.value.toInt() % 100
            : widget.maxProgress;

        return CustomPaint(
          foregroundPainter: DashedCircularProgressPainter(progress: progress),
          child: Container(
            width: 280,
            height: 280,
            color: Colors.transparent,
            child: Center(
              child: Text(
                widget.code,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashedCircularProgressPainter extends CustomPainter {
  final int progress;
  final int totalDashes;
  final double dashLength;
  final double dashThickness;

  DashedCircularProgressPainter({
    required this.progress,
    this.totalDashes = 50,
    this.dashLength = 20,
    this.dashThickness = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = dashThickness
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2.5);

    for (int i = 0; i < totalDashes; i++) {
      final angle = 2 * pi * i / totalDashes;
      final x1 = center.dx + radius * cos(angle);
      final y1 = center.dy + radius * sin(angle);
      final x2 = center.dx + (radius - dashLength) * cos(angle);
      final y2 = center.dy + (radius - dashLength) * sin(angle);

      // Color active dashes with teal, inactive with grey
      paint.color = i < (progress / 100 * totalDashes)
          ? Colors.teal
          : Colors.grey.shade300;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
