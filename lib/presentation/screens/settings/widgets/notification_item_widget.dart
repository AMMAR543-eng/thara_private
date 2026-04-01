import 'package:flutter/cupertino.dart';
import 'package:thara/index/index_main.dart';

class NotificationItemWidget extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;

  const NotificationItemWidget({
    super.key,
    required this.value,
    this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: context.typography.font52Grey.copyWith(
          color: AppColors.darkGray,
        ),
      ),
      trailing: CupertinoSwitch(
        value: value,
        activeTrackColor: AppColors.darkGray.withAlpha(60),
        thumbColor: AppColors.moonstoneBlue,
        inactiveThumbColor: AppColors.whiteSmoke,
        onChanged: onChanged,
      ),
    );
  }
}
