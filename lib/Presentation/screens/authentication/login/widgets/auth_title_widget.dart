import '../../../../../index/index_main.dart';

class AuthTitleWidget extends StatelessWidget {
  final String title;

  const AuthTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: context.typography.myriadSemi46Black,
    );
  }
}
