import '../../../../../index/index_main.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Material(
            type: MaterialType.transparency,
            child: TextButton(
              onPressed: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  LocalStorage_language().read() != "ar"
                      ? FontAwesomeIcons.chevronRight
                      : FontAwesomeIcons.chevronLeft,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
