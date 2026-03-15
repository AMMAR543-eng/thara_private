import '../../../../../index/index_main.dart';

class AuthTextForm extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final String? assetName;
  final void Function()? onTap;
  final String? initialValue;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? readOnly;
  final void Function(bool)? onValidationChanged;
  final int maxLines;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onFieldChange;

  const AuthTextForm({
    super.key,
    required this.hint,
    this.controller,
    this.assetName,
    this.onTap,
    this.initialValue,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly,
    this.onValidationChanged,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.onFieldChange,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      maxLines: maxLines,
      read_only: readOnly,
      controller: controller,
      hintText: hint,
      keyboardType: keyboardType,
      focusNode: focusNode,
      obscureText: obscureText,
      suffixIcon: suffixIcon,
      onValidationChanged: onValidationChanged,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onFieldChange,
      ontap: onTap,
      prefixIcon: assetName != null
          ? Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SvgPicture.asset(
                assetName ?? "",
                height: 25.h,
                width: 25.w,
              ),
            )
          : null,
      validator: validator,
      // Add any custom suffix icon if needed
      enabled: true,
      formaters: const [], // Add any input formatters
    );
  }
}
