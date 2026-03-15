import 'package:thara/index/index_main.dart';

class SingleInfoLine extends StatelessWidget {
  final String title;
  final String value;

  const SingleInfoLine({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 🔹 Title label
          Text(
            title,
            style: context.typography.bodyMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),

          /// 🔹 Value text
          Text(
            value,
            style: context.typography.bodyStrongLarge.copyWith(
              color: AppColors.primary,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
