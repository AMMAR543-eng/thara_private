import 'dart:ui';
import '../../../../../index/index_main.dart';

class PressAnimatedButton extends StatefulWidget {
  const PressAnimatedButton({
    super.key,
    required this.label,
    this.onTap,
    this.enabled = true,
    this.loading = false,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.disabledColor,
    this.leading,
    this.trailing,
    this.expand = true,
  });

  /// The button text/widget (use your context.typography).
  final Widget label;

  /// Tap callback (null is allowed; `enabled=false` also disables).
  final VoidCallback? onTap;

  /// Enable/disable button.
  final bool enabled;

  /// Show a small loading spinner and block taps.
  final bool loading;

  /// Fixed height (defaults to 48.h)
  final double? height;

  /// Internal content padding (defaults to EdgeInsets.symmetric(horizontal: 16.w))
  final EdgeInsetsGeometry? padding;

  /// Corner radius (defaults to 12.r)
  final BorderRadius? borderRadius;

  /// Background color (defaults to AppColors.primary)
  final Color? backgroundColor;

  /// Disabled background (defaults to AppColors.stepper_button_upcomming if exists, else grey)
  final Color? disabledColor;

  /// Optional leading/trailing widgets inside button content row
  final Widget? leading;
  final Widget? trailing;

  /// If true the button takes full width; else wraps content
  final bool expand;

  @override
  State<PressAnimatedButton> createState() => _PressAnimatedButtonState();
}

class _PressAnimatedButtonState extends State<PressAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 120),
    reverseDuration: const Duration(milliseconds: 160),
    value: 0, // 0 = normal, 1 = pressed
  );

  bool get _isInteractive =>
      widget.enabled && !widget.loading && widget.onTap != null;

  void _pressDown() {
    if (!_isInteractive) return;
    _controller.forward();
  }

  void _release() {
    if (!_isInteractive) {
      _controller.reverse();
      return;
    }
    _controller.reverse();
  }

  Color _pressedTint(Color base) {
    // Slight darken on press
    return Color.alphaBlend(Colors.black.withValues(alpha: 0.08), base);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = widget.backgroundColor ?? AppColors.grayLight;
    final Color disabled = widget.disabledColor ?? (AppColors.grayMedium);
    final double height = widget.height ?? 48.h;
    final radius = widget.borderRadius ?? BorderRadius.circular(12.r);
    final EdgeInsetsGeometry padding =
        widget.padding ?? EdgeInsets.symmetric(horizontal: 16.w);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final double t = _controller.value; // 0->normal, 1->pressed
        final double scale = 1.0 - (0.035 * t); // down to ~0.965
        final Color bg = _isInteractive
            ? Color.lerp(baseColor, _pressedTint(baseColor), t)!
            : disabled;

        // Shadow eases between "raised" and "pressed"
        final double blur = lerpDouble(16, 8, t)!;
        final double spread = lerpDouble(1, 0, t)!;
        final double y = lerpDouble(6, 2, t)!;
        final double opacity = _isInteractive
            ? lerpDouble(0.12, 0.18, t)!
            : 0.0;

        Widget content = Row(
          mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              SizedBox(width: 8.w),
            ],
            if (widget.loading)
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            else
              widget.label,
            if (widget.trailing != null) ...[
              SizedBox(width: 8.w),
              widget.trailing!,
            ],
          ],
        );

        return Transform.scale(
          scale: scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeOut,
            width: widget.expand ? double.infinity : null,
            height: height,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: radius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: opacity),
                  blurRadius: blur,
                  spreadRadius: spread,
                  offset: Offset(0, y),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: radius,
                onTap: _isInteractive
                    ? () async {
                        HapticFeedback.lightImpact();
                        widget.onTap?.call();
                      }
                    : null,
                onTapDown: (_) => _pressDown(),
                onTapCancel: _release,
                onTapUp: (_) => _release(),
                child: Padding(
                  padding: padding,
                  child: Center(child: content),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
