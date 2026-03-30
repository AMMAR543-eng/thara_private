// ignore_for_file: must_be_immutable

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import '../../../../../index/index_main.dart';

class PhoneWidget extends StatelessWidget {
  final GlobalKey<FormState> globalKeyPhone;
  final FocusNode focusNode;
  final Color textColor;
  final TextEditingController? controller;
  final Function(String, String, String) onChanged;
  final String label;
  final bool? showAsterisk;
  final double? paddingHorizontal;

  const PhoneWidget({
    Key? key,
    required this.globalKeyPhone,
    required this.focusNode,
    required this.textColor,
    required this.onChanged,
    required this.label,
    this.controller,
    this.showAsterisk,
    this.paddingHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label with optional asterisk
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                if (showAsterisk ?? true)
                  Text(
                    "* ",
                    style: TextStyle(color: ColorMappingImpl().errorTextColor),
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

          /// Phone field with country picker
          Form(
            key: globalKeyPhone,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: IntlPhoneField(
                controller: controller,
                focusNode: focusNode,
                initialCountryCode: "SA",
                keyboardType: TextInputType.number,
                cursorColor: AppColors.primary,
                disableLengthCheck: true,
                pickerDialogStyle: PickerDialogStyle(
                  backgroundColor: AppColors.primary,
                  searchFieldCursorColor: AppColors.primary,
                ),
                searchText: "Search country".tr,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: "",
                  errorStyle: context.typography.font40White,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: context.inputTheme.borderDefault,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: context.inputTheme.borderFocused,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: context.inputTheme.borderError,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: context.inputTheme.borderError,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: context.inputTheme.borderDisabled,
                    ),
                  ),
                ),
                dropdownTextStyle: context.typography.font40White.copyWith(
                  color: textColor,
                ),
                style: context.typography.font40White.copyWith(
                  color: textColor,
                ),
                invalidNumberMessage: "رقم الهاتف غير صحيح".tr,
                onChanged: (phone) {
                  onChanged(
                    phone.completeNumber,
                    phone.number,
                    phone.countryCode,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
