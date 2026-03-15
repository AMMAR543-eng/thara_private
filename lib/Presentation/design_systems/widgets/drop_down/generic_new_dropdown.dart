import '../../../../index/index_main.dart';

class GenericNewDropdown<T> extends StatelessWidget {
  final String title;
  final String hint;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemLabel; // how to display each item
  final void Function(T?) onChanged;
  final bool isRequired;

  const GenericNewDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.selectedItem,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      title: title,
      appTextField: AppTextField(
        read_only: true,
        controller: TextEditingController(
          text: selectedItem != null ? itemLabel(selectedItem as T) : "",
        ),
        hintText: hint,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        validator: isRequired ? notEmptyValidator : null,
        ontap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) {
              return SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final label = itemLabel(item);
                    final isSelected = selectedItem == item;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        onChanged(item);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.focus_input_text,
                                  width: 2,
                                )
                              : Border.all(color: Colors.transparent, width: 1),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.content_secondary,
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Text(
                                label,
                                style: context.typography.bodyLarge.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.content_primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
