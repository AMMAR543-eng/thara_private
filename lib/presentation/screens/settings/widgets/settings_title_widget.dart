import 'package:thara/index/index_main.dart';

class SettingsTitleWidget extends StatelessWidget {
  final String title;

  const SettingsTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: context.typography.headerLarge.copyWith(
          color: AppColors.darkJungleGreen,
        ),
      ),
    );
  }
}
