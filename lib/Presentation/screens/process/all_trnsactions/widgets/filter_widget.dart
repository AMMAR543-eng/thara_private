import '../../../../../index/index_main.dart';

class FilterWidget extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final VoidCallback? onFilterTap;
  final VoidCallback? onAddTap;

  const FilterWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.index,
    this.onFilterTap,
    this.onAddTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = ColorMappingImpl();

    return Container(
      color: colors.backgroundDefault,
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15,
        top: 15,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: context.typography.font49Red.copyWith(
                    color: colors.textDisplay,
                  ),
                ),
                // Subtitle
                Text(
                  subtitle,
                  style: context.typography.font33Grey.copyWith(
                    color: colors.textSecondaryParagraph,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),
          // Filter Button
          Visibility(
            visible: index == 2,
            child: Row(
              children: [
                InkWell(
                  onTap: onAddTap,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: colors.background_neutral_default,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, size: 25),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Visibility(
            visible: index != 2,
            child: Row(
              children: [
                InkWell(
                  onTap: onFilterTap,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: colors.background_neutral_default,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(Images.filter),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
