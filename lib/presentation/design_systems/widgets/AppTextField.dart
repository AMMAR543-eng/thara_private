import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../index/index.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.textColor,
    this.hintColor,
    this.enabled = true,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.helperText,
    this.formaters,
    this.errorText,
    this.suffixIcon,
    this.focusNode,
    this.show_shadow = true,
    this.prefixIcon,
    this.keyboardType,
    this.read_only,
    this.ontap,
    this.textInputAction = TextInputAction.done,
    this.maxLines = 1,
    this.onValidationChanged,
    this.onFieldSubmitted,

    // 🔥 NEW (Accessibility)
    this.semanticsLabel,
    this.semanticsHint,
  });

  final TextEditingController? controller;
  final String? labelText;
  final Color? textColor;
  final Color? hintColor;
  final VoidCallback? ontap;
  final bool? read_only;
  final String? hintText;
  final bool enabled;
  final bool show_shadow;
  final FocusNode? focusNode;
  final bool obscureText;
  final List<TextInputFormatter>? formaters;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? helperText;
  final String? errorText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final ValueChanged<bool>? onValidationChanged;
  final void Function(String)? onFieldSubmitted;

  // 🔥 Accessibility fields
  final String? semanticsLabel;
  final String? semanticsHint;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFieldChanged(String value) {
    final validationError = widget.validator?.call(value);
    final isValid = validationError == null;

    if (widget.onValidationChanged != null) {
      widget.onValidationChanged!(isValid);
    }

    setState(() {
      _errorText = validationError;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,

      // 🔥 Smart fallback
      label: widget.semanticsLabel ??
          widget.labelText ??
          widget.hintText ??
          "Input field",

      hint: widget.semanticsHint ?? widget.hintText,

      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.controller,
        enabled: widget.enabled,
        obscureText: widget.obscureText,
        onTap: widget.ontap,
        readOnly: widget.read_only ?? false,
        focusNode: _focusNode,
        inputFormatters: widget.formaters,
        onChanged: _onFieldChanged,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyboardType ?? TextInputType.name,
        textInputAction: widget.textInputAction,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        cursorColor: context.inputTheme.focusedTextColor,
        style: context.typography.bodyMedium.copyWith(
          color: widget.enabled
              ? (widget.textColor ?? context.inputTheme.focusedTextColor)
              : context.inputTheme.disabledTextColor,
        ),
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: context.typography.bodyMedium.copyWith(
            color: AppColors.tertiary,
          ),
          filled: true,
          fillColor: AppColors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.inputTheme.borderDefault),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.inputTheme.borderFocused),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.inputTheme.borderError),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.inputTheme.borderError),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.inputTheme.borderDisabled),
            borderRadius: BorderRadius.circular(8),
          ),
          errorText: _errorText,
          helperText: widget.helperText,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          errorStyle: context.typography.bodySmall.copyWith(
            overflow: TextOverflow.visible,
            color: AppColors.errorForeground,
          ),
        ),
      ),
    );
  }
}
