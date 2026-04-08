import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:thara/index/index.dart';
import 'package:thara/presentation/screens/process/process_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Process View Test', () {
    testWidgets('Process screen loads without crash', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProcessView(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      // ✅ الشاشة فتحت
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}