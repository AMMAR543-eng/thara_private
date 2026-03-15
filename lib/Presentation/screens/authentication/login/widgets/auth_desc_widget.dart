import '../../../../../index/index_main.dart';

class AuthDescWidget extends StatelessWidget {
  final String desc;

  const AuthDescWidget({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.h),
      child: Text(
        desc,
        textAlign: TextAlign.center,
        style: context.typography.font52Grey.copyWith(
          color: AppColors.darkGray,
        ),
      ),
    );
  }
}
