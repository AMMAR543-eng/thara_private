
import 'dart:ui';
import '../../../../index/index_main.dart';

class PressScaleWrapper extends StatefulWidget {
  const PressScaleWrapper({
    super.key,
    required this.child,
    this.enabled = true,
    this.radius,
    this.scaleDown = 0.965,
    this.durationIn = const Duration(milliseconds: 120),
    this.durationOut = const Duration(milliseconds: 160),
  });

  final Widget child;
  final bool enabled;
  final BorderRadius? radius;
  final double scaleDown;
  final Duration durationIn;
  final Duration durationOut;

  @override
  State<PressScaleWrapper> createState() => _PressScaleWrapperState();
}

class _PressScaleWrapperState extends State<PressScaleWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.durationIn,
    reverseDuration: widget.durationOut,
    value: 0,
  );

  bool _pressed = false;

  void _down() {
    if (!widget.enabled) return;
    _pressed = true;
    _c.forward();
  }

  void _up() {
    if (!_pressed) return;
    _pressed = false;
    _c.reverse();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.radius ?? BorderRadius.circular(12.r);

    return Listener(
      onPointerDown: (_) => _down(),
      onPointerCancel: (_) => _up(),
      onPointerUp: (_) => _up(),
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) {
          final t = _c.value;
          final scale = 1.0 - (1.0 - widget.scaleDown) * t;

          final blur = lerpDouble(16, 8, t)!;
          final spread = lerpDouble(1, 0, t)!;
          final y = lerpDouble(6, 2, t)!;
          final opacity = lerpDouble(0.12, 0.18, t)!;

          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: widget.durationIn,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                borderRadius: radius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(opacity),
                    blurRadius: blur,
                    spreadRadius: spread,
                    offset: Offset(0, y),
                  ),
                ],
              ),
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
