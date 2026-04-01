import '../../../../index/index_main.dart';

class AddBalanceBottomSheet extends StatelessWidget {
  AddBalanceBottomSheet({super.key});

  final RxInt selectedMethod = 0.obs;
  final RxBool saveCard = true.obs;

  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SafeArea(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Handle bar
                Container(
                  width: 36.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.border_default,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),

                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(40.w, 30.h),
                      ),
                      child: Text(
                        "cancel".tr,
                        style: typography.bodyMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Text(
                      "add_balance".tr,
                      style: typography.headerLarge.copyWith(
                        color: AppColors.content_primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
                SizedBox(height: 16.h),

                /// Section title
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "choose_payment_method".tr,
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.content_brand_secondary,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                /// --- Credit/Debit card option
                _buildPaymentOption(
                  context,
                  index: 0,
                  isSelected: selectedMethod.value == 0,
                  title: "credit_or_debit_card".tr,
                  trailingIcons: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(IconsConstants.bank_logo, height: 16.h),
                    ],
                  ),
                  onTap: () => selectedMethod.value = 0,
                ),

                /// --- Credit Card Form
                if (selectedMethod.value == 0) _buildCreditCardForm(context),

                /// Divider line
                Container(
                  width: double.infinity,
                  height: 1,
                  color: AppColors.border_default,
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                ),

                /// --- Apple Pay / Bank card option
                _buildPaymentOption(
                  context,
                  index: 1,
                  isSelected: selectedMethod.value == 1,
                  title: "bank_card".tr,
                  trailingIcons: SvgPicture.asset(
                    IconsConstants.apple_pay,
                    height: 24.h,
                  ),
                  onTap: () => selectedMethod.value = 1,
                ),

                SizedBox(height: 30.h),

                /// --- Next Button
                PrimaryTextButton(
                  onTap: () {
                    Loader.showSuccess("deposit_method_selected".tr);
                    Get.back();
                  },
                  appButtonSize: AppButtonSize.xxLarge,
                  customBackgroundColor: AppColors.action_primary_normal,
                  label: Text(
                    "next".tr,
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// --- Credit Card Form Section
  Widget _buildCreditCardForm(BuildContext context) {
    final typography = context.typography;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomInputField(
            label: "cardholder_name".tr,
            hintText: "cardholder_name".tr,
            controller: cardNameController,
            keyboardType: TextInputType.name,
            show_asterisc: false,
            focusNode: FocusNode(),
            validator: (v) {},
          ),
          SizedBox(height: 12.h),

          CustomInputField(
            label: "card_number".tr,
            hintText: "0000 0000 0000 0000",
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            show_asterisc: false,
            focusNode: FocusNode(),
            validator: (v) {},
          ),
          SizedBox(height: 12.h),

          /// Expiry + CVV
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  label: "expiry_date".tr,
                  hintText: "month_year".tr,
                  controller: expiryController,
                  keyboardType: TextInputType.datetime,
                  sufixIcon: Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: AppColors.content_secondary,
                  ),
                  show_asterisc: false,
                  focusNode: FocusNode(),
                  validator: (v) {},
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomInputField(
                  label: "cvv_code".tr,
                  hintText: "000",
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  show_asterisc: false,
                  focusNode: FocusNode(),
                  validator: (v) {},
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Save card checkbox
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "save_card_for_future".tr,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
              SizedBox(width: 8.w),
              Obx(
                () => Checkbox(
                  value: saveCard.value,
                  onChanged: (v) => saveCard.value = v ?? true,
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// --- Reusable Payment Option
  Widget _buildPaymentOption(
    BuildContext context, {
    required int index,
    required bool isSelected,
    required String title,
    Widget? trailingIcons,
    required VoidCallback onTap,
  }) {
    final typography = context.typography;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border_default,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.border_default,
              size: 22.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                title,
                style: typography.bodyStrongLarge.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
            ),
            if (trailingIcons != null) trailingIcons,
          ],
        ),
      ),
    );
  }
}
