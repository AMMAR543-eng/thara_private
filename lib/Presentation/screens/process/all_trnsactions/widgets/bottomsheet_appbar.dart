import '../../../../../../../index/index_main.dart';

class BottomSheetAppBar extends StatelessWidget {
  final String title;

  const BottomSheetAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              title,
              style: context.typography.font40White
                  .copyWith(color: AppColors.textFormTitle),
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: const Svgicon(icon: IconsConstants.Button_Close),
        // ),
      ],
    );
  }
}
