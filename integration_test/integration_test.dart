import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thara/index/index_main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Statistics View Test', () {
    testWidgets('Statistics screen loads without crash', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: StatiscticsView(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // ✅ الشاشة ظهرت
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}