import '../../../../../index/index_main.dart';

class ExpansionItemWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? groupValue;
  final void Function(String?) onChanged;

  const ExpansionItemWidget({
    super.key,
    required this.onChanged,
    this.groupValue,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: AppColors.darkGray),
              child: Expanded(
                child: RadioListTile<String>(
                  title: Text(
                    title,
                    textDirection: TextDirection.rtl,
                    style: context.typography.xSmallTitle21.copyWith(
                      color: AppColors.darkGray,
                    ),
                  ),
                  value: value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
