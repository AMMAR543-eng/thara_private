import '../../../../index/index_main.dart';

class DateField extends StatelessWidget {
  final String label;
  String? hint;
  String? icon;
  final TextEditingController controller;
  final VoidCallback onpress;

  DateField({
    Key? key,
    required this.label,
    this.icon,
    this.hint,
    required this.controller,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.font33Grey.copyWith(
            color: AppColors.textDisplay,
          ), // Update based on your theme
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppTextField(
            show_shadow: false,
            controller: controller,
            prefixIcon: icon != null
                ? const Icon(Icons.calendar_today_outlined)
                : null,
            hintText: hint ?? "choose_date".tr,
            ontap: () async {
              Get.bottomSheet(
                Container(
                  color: AppColors.white,
                  child: GenericDatePicker(
                    hasValue: controller.text.isEmpty ? false : true,
                    onDateSelected: (value) {
                      controller.text = value;
                      onpress();
                    },
                  ),
                ),
              );
            },
            read_only: true,
          ),
        ),
      ],
    );
  }
}
