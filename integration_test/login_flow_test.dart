import 'package:flutter_test/flutter_test.dart';
import 'package:thara/index/index.dart';
import 'package:thara/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Integration Test', () {
    testWidgets('User can enter email & password and tap login',
            (tester) async {
          await tester.pumpWidget(const MyApp());

          await tester.pumpAndSettle();

          // 🟡 Enter Email
          await tester.enterText(
            find.byType(TextField).at(0),
            'test@test.com',
          );

          // 🟡 Enter Password
          await tester.enterText(
            find.byType(TextField).at(1),
            '123456',
          );

          await tester.pumpAndSettle();

          // 🟢 Tap Login Button
          await tester.tap(find.byType(PrimaryTextButton).first);

          await tester.pumpAndSettle(const Duration(seconds: 5));

          // ✅ أهم حاجة: مفيش crash
          expect(find.byType(Scaffold), findsWidgets);
        });
  });
}