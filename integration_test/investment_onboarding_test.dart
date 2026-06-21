import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thara/index/index_main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Investment Onboarding Test', () {
    testWidgets('User navigates to wizard from onboarding',
            (tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: InvestmentOnboardingScreen(),
            ),
          );

          await tester.pumpAndSettle();

          // 🟢 اضغط زرار activate
          await tester.tap(find.byType(PressAnimatedButton));

          await tester.pumpAndSettle(const Duration(seconds: 3));

          // ✅ تأكد إنه راح للـ Wizard
          expect(find.byType(InvestmentWizardScreen), findsOneWidget);
        });
  });
}