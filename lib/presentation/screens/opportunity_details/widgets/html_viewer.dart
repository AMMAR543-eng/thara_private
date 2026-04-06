import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../index/index.dart';

class HtmlViewer extends StatelessWidget {
  final String? htmlData;

  const HtmlViewer({super.key, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      htmlData ?? "",
      textStyle: TextStyle(color: AppColors.textDefault),
    );
  }
}
