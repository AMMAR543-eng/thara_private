import '../../../index/index_main.dart';

class TextInputWidget extends StatelessWidget {
  final String title;
  final AppTextField appTextField;

  const TextInputWidget({
    super.key,
    required this.title,
    required this.appTextField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: context.typography.bodyLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        appTextField,
      ],
    );
  }
}
