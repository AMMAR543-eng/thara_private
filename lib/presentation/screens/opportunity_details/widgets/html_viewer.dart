import 'package:flutter_html/flutter_html.dart';

import '../../../../index/index.dart';

class HtmlViewer extends StatelessWidget {
  final String? htmlData;

  const HtmlViewer({super.key, required this.htmlData});

  @override
  Widget build(BuildContext context) {
    return Html(data: htmlData ?? "");
  }
}
