import '../../../../../../index/index_main.dart';

class InfoTextColumn extends StatelessWidget {
  final String title;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final TextAlign textAlign;

  const InfoTextColumn({
    super.key,
    required this.title,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.0.h),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          /// Title
          Text(
            title,
            textAlign: textAlign,
            style: typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),

          /// Value
          Text(
            value.isNotEmpty ? value : "-",
            textAlign: textAlign,
            style: typography.bodyStrongLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
