import 'package:thara/Presentation/design_systems/widgets/check_box/check_box_double_border.dart';
import 'package:thara/index/index_main.dart';

class SelectableCardCheckBoxWidget extends StatelessWidget {
  final String title;
  final String? iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableCardCheckBoxWidget({
    super.key,
    required this.title,
    this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 125.h,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.content_positive_secondary
                : AppColors.border_default,

            width: 3,
          ),
        ),
        child: Stack(
          children: [
            // ✅ Outer double border effect
            if (isSelected)
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.border_default, // ✅ FIX
                      width: 2,
                    ),
                  ),
                ),
              ),

            // ✅ Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ✅ Checkbox with double border
                  Align(
                    alignment: LocalStorage_language().read() == "ar"
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: DoubleBorderCheckbox(
                      isSelected: isSelected,
                      outerSelectedColor: AppColors.content_positive_secondary,
                      outerUnselectedColor: AppColors.border_default,
                      // ✅
                      innerSelectedColor: AppColors.primary_active,
                      // ✅
                      innerBorderColor: AppColors.border_default, // ✅
                    ),
                  ),

                  // ✅ Title + Icon Bottom Row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        iconPath == null
                            ? const SizedBox()
                            : Svgicon(
                                icon: iconPath!,
                                width: 28.w,
                                height: 28.h,
                                color: AppColors.primary,
                              ),
                        const SizedBox(width: 10),
                        Text(
                          title,
                          style: context.typography.bodyLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
