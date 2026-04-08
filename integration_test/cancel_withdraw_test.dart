import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thara/index/index.dart';
import 'package:thara/presentation/screens/process/withdraw/cancel_bottomsheet.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Cancel Withdraw BottomSheet Test', () {
    testWidgets('User can open and confirm cancel withdraw',
            (tester) async {
          bool confirmed = false;

          await tester.pumpWidget(
            MaterialApp(
              home: Builder(
                builder: (context) {
                  return Scaffold(
                    body: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showCancelWithdrawBottomSheet(
                            context: context,
                            onConfirm: () {
                              confirmed = true;
                            },
                          );
                        },
                        child: const Text('Open'),
                      ),
                    ),
                  );
                },
              ),
            ),
          );

          await tester.pumpAndSettle();

          // 🟡 افتح الـ BottomSheet
          await tester.tap(find.text('Open'));
          await tester.pumpAndSettle();

          // 🟢 تأكد إنه ظهر
          expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);

          // 🟣 اضغط Confirm
          await tester.tap(find.textContaining('confirm'));
          await tester.pumpAndSettle();

          // ✅ تأكد إن الكولباك اشتغل
          expect(confirmed, true);
        });
  });
}