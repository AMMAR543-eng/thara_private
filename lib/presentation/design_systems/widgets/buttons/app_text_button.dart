import 'package:thara/index/index_main.dart';

typedef IconBuilder = Widget Function(Color iconColor);

abstract class AppTextButton extends StatelessWidget {
  /// {@macro app_text_button}
  const AppTextButton({
    super.key,
    required this.label,
    this.onTap,
    this.leading,
    this.elevation,
    this.trailing,
    this.appButtonSize = AppButtonSize.large,
  });

  /// The label for the text button.
  final Text label;

  final double? elevation;

  /// The callback function for the text button.
  final VoidCallback? onTap;

  /// The leading icon for the text button.
  final IconBuilder? leading;

  /// The trailing icon for the text button.
  final IconBuilder? trailing;

  /// The size of the text button.
  final AppButtonSize appButtonSize;

  /// The background color for the text button.
  Color backgroundColor(BuildContext context);

  /// The focus color for the text button.
  Color focusColor(BuildContext context);

  Color hoverColor(BuildContext context);

  /// The disabled color for the text button.
  Color disabledColor(BuildContext context);

  /// The text color for the text button.
  Color textColor(BuildContext context);

  /// The disabled text color for the text button.
  Color disabledTextColor(BuildContext context) {
    return context.buttonTheme.buttonDisabledTextColor;
  }

  /// The default border for the text button.
  BorderSide defaultBorder(BuildContext context) => BorderSide.none;

  /// The focused border for the text button.
  BorderSide focusedBorder(BuildContext context) => BorderSide.none;

  /// The hover border for the text button.
  BorderSide hoverBorder(BuildContext context) => BorderSide.none;

  /// The disabled border for the text button.
  BorderSide disabledBorder(BuildContext context) => BorderSide.none;

  @override
  Widget build(BuildContext context) {
    final betweenSpace = switch (appButtonSize) {
      AppButtonSize.small ||
      AppButtonSize.xSmall ||
      AppButtonSize.medium => AppSpacing.x2,
      AppButtonSize.large || AppButtonSize.xlarge => AppSpacing.x8,
      AppButtonSize.xxLarge => AppSpacing.x12,
    };

    final inputTextColor = WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabledTextColor(context);
      }

      return textColor(context);
    });

    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(elevation ?? 2),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledColor(context);
          }

          if (states.contains(WidgetState.focused)) {
            return focusColor(context);
          }

          if (states.contains(WidgetState.pressed)) {
            return focusColor(context);
          }

          return backgroundColor(context);
        }),
        shape: WidgetStateProperty.resolveWith((states) {
          var shape = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.x6),
          );

          if (states.contains(WidgetState.disabled)) {
            return shape.copyWith(side: disabledBorder(context));
          }

          if (states.contains(WidgetState.focused)) {
            return shape.copyWith(side: focusedBorder(context));
          }

          if (states.contains(WidgetState.hovered)) {
            return shape.copyWith(side: hoverBorder(context));
          }

          if (states.contains(WidgetState.pressed)) {
            return shape.copyWith(side: focusedBorder(context));
          }

          return shape.copyWith(side: defaultBorder(context));
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return disabledColor(context);
          }

          if (states.contains(WidgetState.focused)) {
            return focusColor(context);
          }

          if (states.contains(WidgetState.hovered)) {
            return hoverColor(context);
          }

          if (states.contains(WidgetState.pressed)) {
            return focusColor(context);
          }

          return backgroundColor(context);
        }),
        foregroundColor: inputTextColor,
        fixedSize: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.small ||
          AppButtonSize.xSmall => Size(double.infinity, 36.h),
          AppButtonSize.medium => Size(double.infinity, 40.h),
          AppButtonSize.large => Size(double.infinity, 44.h),
          AppButtonSize.xlarge => Size(double.infinity, 48.h),
          AppButtonSize.xxLarge => Size(double.infinity, 110.h),
        }),
        padding: WidgetStateProperty.all(switch (appButtonSize) {
          AppButtonSize.small ||
          AppButtonSize.xSmall => EdgeInsets.symmetric(horizontal: 12.w),
          AppButtonSize.medium => EdgeInsets.symmetric(horizontal: 16.w),
          AppButtonSize.large => EdgeInsets.symmetric(horizontal: 16.w),
          AppButtonSize.xlarge => EdgeInsets.symmetric(horizontal: 20.w),
          AppButtonSize.xxLarge => EdgeInsets.symmetric(horizontal: 24.w),
        }),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!(
              onTap != null ? textColor(context) : disabledTextColor(context),
            ),
            SizedBox(width: betweenSpace),
          ],
          label,
          if (trailing != null) ...[
            SizedBox(width: betweenSpace),
            trailing!(
              onTap != null ? textColor(context) : disabledTextColor(context),
            ),
          ],
        ],
      ),
    );
  }
}
