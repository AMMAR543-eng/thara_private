

import '../../../../../index/index.dart';

class PaginationLoader extends StatelessWidget {
  const PaginationLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.brown,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
