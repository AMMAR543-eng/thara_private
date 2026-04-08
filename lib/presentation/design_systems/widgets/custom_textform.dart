import '../../../../../index/index_main.dart';

/// Custom formatter to convert Arabic digits (٠١٢٣٤٥٦٧٨٩) to English digits (0123456789).
class ArabicToEnglishDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAllMapped(
      RegExp(r'[٠١٢٣٤٥٦٧٨٩]'),
          (match) {
        switch (match.group(0)) {
          case '٠':
            return '0';
          case '١':
            return '1';
          case '٢':
            return '2';
          case '٣':
            return '3';
          case '٤':
            return '4';
          case '٥':
            return '5';
          case '٦':
            return '6';
          case '٧':
            return '7';
          case '٨':
            return '8';
          case '٩':
            return '9';
          default:
            return match.group(0)!;
        }
      },
    );
    return newValue.copyWith(text: newText, selection: newValue.selection);
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? prefixIcon;
  final Widget? sufixIcon;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final String? Function(String?) validator;
  final ValueChanged<String>? voidCallbackAction;
  final bool obscureText;
  final bool? show_asterisc;
  final double? padding_horizontal;

  // 🔥 NEW (Accessibility)
  final String? semanticsLabel;
  final String? semanticsHint;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.sufixIcon,
    this.show_asterisc,
    this.voidCallbackAction,
    this.padding_horizontal,
    required this.keyboardType,
    required this.focusNode,
    required this.validator,
    this.obscureText = false,

    // 🔥 NEW
    this.semanticsLabel,
    this.semanticsHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatters;
    if (keyboardType == TextInputType.number ||
        (keyboardType.toString().contains('number'))) {
      inputFormatters = [ArabicToEnglishDigitsFormatter()];
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding_horizontal ?? 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 label (optional semantics enhancement)
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Visibility(
                  visible: show_asterisc == null,
                  child: Text(
                    "* ",
                    style: TextStyle(color: ColorMappingImpl().errorTextColor),
                  ),
                ),
                Text(
                  label,
                  style: context.typography.font40White.copyWith(
                    color: ColorMappingImpl().textLabel,
                  ),
                ),
              ],
            ),
          ),

          /// 🔥 FIELD (Semantics هنا بيتم تمريره)
          AppTextField(
            controller: controller,
            hintText: hintText,
            keyboardType: keyboardType,
            focusNode: focusNode,
            obscureText: obscureText,
            prefixIcon: prefixIcon != null && prefixIcon!.isNotEmpty
                ? Image.asset(prefixIcon!)
                : null,
            suffixIcon: sufixIcon,
            validator: validator,
            onChanged: voidCallbackAction,
            enabled: true,
            formaters: inputFormatters,

            // 🔥 IMPORTANT
            semanticsLabel: semanticsLabel ?? label,
            semanticsHint: semanticsHint ?? hintText,
          ),
        ],
      ),
    );
  }
}