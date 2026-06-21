import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:thara/index/index.dart';
import 'package:thara/presentation/screens/dashboard/home_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home View Test', () {
    testWidgets('Home screen loads without crash', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeView(),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 5));

      // ✅ الشاشة ظهرت
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}