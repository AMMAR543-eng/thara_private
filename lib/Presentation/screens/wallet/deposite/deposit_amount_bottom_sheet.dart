import '../../../../index/index_main.dart';

class DepositAmountBottomSheet extends StatefulWidget {
  const DepositAmountBottomSheet({super.key});

  @override
  State<DepositAmountBottomSheet> createState() =>
      _DepositAmountBottomSheetState();
}

class _DepositAmountBottomSheetState extends State<DepositAmountBottomSheet> {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 24.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 50.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.background_neutral_surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "add_balance".tr,
              style: context.typography.bodyLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 12.h),

            AppTextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              hintText: "enter_amount".tr,
            ),

            SizedBox(height: 20.h),

            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: AuthButtonWidget(
                title: "continue".tr,
                onPressed: () {
                  final amount = int.tryParse(amountController.text);

                  if (amount == null || amount <= 0) {
                    Loader.showError("invalid_amount".tr);
                    return;
                  }

                  Get.back(); // close bottom sheet

                  /// 👉 go to payment screen with amount
                  Get.to(() => Test(amount: amount));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
