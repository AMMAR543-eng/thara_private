import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thara/index/index.dart';
import 'package:thara/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Deposit Flow Integration Test', () {
    testWidgets('User opens deposit and navigates to bank transfer',
            (tester) async {
          await tester.pumpWidget(const MyApp());

          await tester.pumpAndSettle();

          // 🟡 افتح الصفحة اللي فيها deposit
          // ⚠️ عدل دي حسب مكان الزر عندك
          // مثال:
          // await tester.tap(find.text('Deposit'));

          await tester.pumpAndSettle();

          // 🟢 افتح BottomSheet
          // لو عندك زر بيفتحها
          // await tester.tap(find.byType(YourDepositButton));

          await tester.pumpAndSettle();

          // 🟣 اضغط على Bank Transfer
          await tester.tap(find.textContaining('bank'));

          await tester.pumpAndSettle(const Duration(seconds: 5));

          // ✅ تحقق إن الصفحة الجديدة فتحت
          expect(find.byType(Scaffold), findsWidgets);
        });
  });
}