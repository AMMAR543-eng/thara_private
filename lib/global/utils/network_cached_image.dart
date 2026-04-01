import '../../index/index_main.dart';

class NetworkAttachmentImage extends StatelessWidget {
  const NetworkAttachmentImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit boxFit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: boxFit,
      placeholder: (context, url) =>
          placeholder ??
          SizedBox(
            width: width,
            height: height,
            child: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            width: width ?? 100,
            height: height ?? 100,
            color: Colors.grey[200],
            child: Image.asset(Images.placeholder, fit: BoxFit.cover),
          ),
    );
  }
}
