import 'package:thara/index/index_main.dart';

class InfoItemWidget extends StatelessWidget {
  final String label;
  final String value;
  final AppTypography typography;
  final bool showEdit;
  final void Function()? onTap;

  const InfoItemWidget({
    super.key,
    required this.label,
    required this.value,
    required this.typography,
    required this.showEdit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: typography.fontNewBlack45),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: typography.font55GreyLeft.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          if (showEdit)
            GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                IconsConstants.edit,
                fit: BoxFit.contain,
                height: 50.h,
                width: 50.w,
              ),
            ),
        ],
      ),
    );
  }
}
