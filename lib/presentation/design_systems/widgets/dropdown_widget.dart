import '../../../index/index.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    this.onChanged,
    this.value,
    this.hint,
    this.labelText,
    this.errorText,
    this.helperText,
    this.isExpanded = false,
    this.enabled = true,
    this.icon,

    // 🔥 NEW (Accessibility)
    this.semanticsLabel,
    this.semanticsHint,
  });

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final Widget? hint;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final bool isExpanded;
  final bool enabled;
  final Widget? icon;

  // 🔥 Accessibility
  final String? semanticsLabel;
  final String? semanticsHint;

  @override
  Widget build(BuildContext context) {
    final dropdownTheme = context.appDropdownTheme;

    /// 🔥 Extract current selected value as readable text
    String? selectedValueText;
    if (value != null) {
      final selectedItem = items.firstWhere(
            (item) => item.value == value,
        orElse: () => items.first,
      );

      if (selectedItem.child is Text) {
        selectedValueText = (selectedItem.child as Text).data;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labelText!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: dropdownTheme.textColor,
              ),
            ),
          ),

        /// 🔥 Semantics wrapper
        Semantics(
          button: true,
          enabled: enabled,

          // 🔥 Smart label
          label: semanticsLabel ??
              labelText ??
              "Dropdown selection",

          // 🔥 Important hint for screen readers
          hint: semanticsHint ??
              "Double tap to open options",

          // 🔥 Current value (VERY IMPORTANT)
          value: selectedValueText,

          child: DropdownButtonFormField<T>(
            items: items,
            value: value,
            hint: hint,
            isExpanded: isExpanded,
            onChanged: enabled ? onChanged : null,
            icon: icon ??
                Icon(Icons.arrow_drop_down,
                    color: dropdownTheme.iconColor),
            iconSize: dropdownTheme.iconSize,
            style: TextStyle(color: dropdownTheme.textColor),
            dropdownColor: dropdownTheme.menuBackgroundColor,
            menuMaxHeight: dropdownTheme.menuMaxHeight,
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled
                  ? dropdownTheme.backgroundColor
                  : dropdownTheme.disabledBackgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                dropdownTheme.borderRadius as BorderRadius,
                borderSide: BorderSide(
                  color: dropdownTheme.borderColor,
                  width: dropdownTheme.borderWidth,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                dropdownTheme.borderRadius as BorderRadius,
                borderSide: BorderSide(
                  color: dropdownTheme.borderColor,
                  width: dropdownTheme.borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                dropdownTheme.borderRadius as BorderRadius,
                borderSide: BorderSide(
                  color: dropdownTheme.focusedBorderColor,
                  width: dropdownTheme.borderWidth,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                dropdownTheme.borderRadius as BorderRadius,
                borderSide: BorderSide(
                  color: dropdownTheme.borderColor,
                  width: dropdownTheme.borderWidth,
                ),
              ),
              helperText: helperText,
              helperStyle: TextStyle(color: dropdownTheme.textColor),
              errorText: errorText,
              errorStyle:
              TextStyle(color: dropdownTheme.unselectedItemColor),
            ),
          ),
        ),
      ],
    );
  }
}