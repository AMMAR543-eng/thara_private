import '../../../../../index/index_main.dart';

class AuthButtonWidget extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool next;

  const AuthButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.next = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth - 80.w,
      child: PrimaryTextButton(
        appButtonSize: AppButtonSize.xxLarge,
        trailing: next
            ? (value) {
                return SvgPicture.asset(
                  IconsConstants.arrow,
                  fit: BoxFit.contain,
                  color: AppColors.white,
                  height: 17.h,
                  // width: 20.getWidth(),
                );
              }
            : null,
        onTap: onPressed,
        label: Text(
          title.tr,
          style: context.typography.bodyLarge.copyWith(
            color: AppColors.whiteSmoke,
          ),
        ),
      ),
    );
  }
}
