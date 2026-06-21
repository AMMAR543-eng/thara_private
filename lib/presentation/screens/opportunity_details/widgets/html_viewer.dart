import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../index/index.dart';

class HtmlViewer extends StatelessWidget {
  final String? htmlData;

  const HtmlViewer({super.key, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColors.textDefault;

    return HtmlWidget(
      htmlData ?? "",
      textStyle: TextStyle(color: textColor),
      customStylesBuilder:
          isDark ? (element) => {'color': '${_toCssHex(textColor)}'} : null,
    );
  }

  static String _toCssHex(Color c) {
    final r = c.red.toInt().toRadixString(16).padLeft(2, '0');
    final g = c.green.toInt().toRadixString(16).padLeft(2, '0');
    final b = c.blue.toInt().toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}
