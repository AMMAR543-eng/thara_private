import '../../index/index_main.dart';

class Svgicon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? height;
  final double? width;
  final double? padding;

  const Svgicon({
    Key? key,
    required this.icon,
    this.padding,
    this.color,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 0),
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(color!, BlendMode.srcIn),
        height: height,
        width: width,
      ),
    );
  }
}
