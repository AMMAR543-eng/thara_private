import '../../../../../index/index_main.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      IconsConstants.logo,
      color: AppColors.primary,
      fit: BoxFit.contain,
      height: 120.h,
      width: 120.w,
    );
  }
}
