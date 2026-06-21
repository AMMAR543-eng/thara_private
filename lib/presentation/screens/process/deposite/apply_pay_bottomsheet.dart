import '../../../../../index/index_main.dart';

class ApplePayBottomSheet extends StatefulWidget {
  const ApplePayBottomSheet({super.key});

  @override
  State<ApplePayBottomSheet> createState() => _ApplePayBottomSheetState();
}

class _ApplePayBottomSheetState extends State<ApplePayBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  String? _errorText;

  bool get _isValidAmount {
    final value = int.tryParse(_amountController.text);
    return value != null && value >= 1000;
  }

  void _onAmountSelected(String amount) {
    setState(() {
      _amountController.text = amount;
      _errorText = null;
    });
  }

  void _onChanged(String text) {
    setState(() {
      final value = int.tryParse(text);
      if (value != null && value < 1000) {
        _errorText = 'min_limit_error'.tr;
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// --- Handle
              Center(
                child: Container(
                  width: 60.w,
                  height: 5.h,
                  margin: EdgeInsets.only(bottom: 15.h),
                  decoration: BoxDecoration(
                    color: AppColors.border_natural_normal,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),

              /// --- Title
              Center(
                child: Text(
                  'enter_deposit_amount'.tr,
                  style: typography.headerXLarge.copyWith(
                    color: AppColors.content_brand_secondary,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// --- Input field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border_natural_normal),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        style: typography.bodyLarge.copyWith(
                          color: AppColors.content_primary,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: typography.bodyMedium.copyWith(
                            color: AppColors.tertiary,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: _onChanged,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.currency_exchange_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ],
                ),
              ),

              /// --- Error message
              if (_errorText != null)
                Padding(
                  padding: EdgeInsets.only(top: 6.h, right: 4.w),
                  child: Text(
                    _errorText!,
                    style: typography.bodyMedium.copyWith(
                      color: AppColors.errorForeground,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),

              SizedBox(height: 8.h),

              /// --- Minimum amount text
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "min_investment_note".tr,
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.content_secondary,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              /// --- Quick amount buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final amount in ['1000', '5000', '10000'])
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => _onAmountSelected(amount),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.primary),
                          ),
                          child: Center(
                            child: Text(
                              amount,
                              style: typography.bodyLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(height: 30.h),

              /// --- Apple Pay Button
              SizedBox(
                height: 55.h,
                width: double.infinity,
                child: PrimaryTextButton(
                  appButtonSize: AppButtonSize.xxLarge,
                  customBackgroundColor: AppColors.background_black,
                  onTap: _isValidAmount
                      ? () {
                          Get.back();
                        }
                      : null,
                  label: Text(
                    'pay_with_apple'.tr,
                    style: typography.bodyLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
