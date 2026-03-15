import '../../../../../index/index_main.dart';

class AddBankAccountBottomSheet extends StatefulWidget {
  const AddBankAccountBottomSheet({super.key});

  @override
  State<AddBankAccountBottomSheet> createState() =>
      _AddBankAccountBottomSheetState();
}

class _AddBankAccountBottomSheetState extends State<AddBankAccountBottomSheet> {
  final formKey = GlobalKey<FormState>();
  late final StoreBankController controller;

  /// ✅ نستخدم initState هنا في مكانها الصحيح
  @override
  void initState() {
    super.initState();
    controller = Get.put(StoreBankController(), permanent: false);
    controller.getBankAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return GetBuilder<StoreBankController>(
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Handle bar
                    Container(
                      width: 60.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: AppColors.border_default,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(height: 18.h),

                    /// 🔹 Title
                    Text(
                      "add_bank_account_info".tr,
                      style: typography.headerXLarge.copyWith(
                        color: AppColors.content_primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),

                    /// 🔹 Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "add_bank_account_subtitle".tr,
                        style: typography.bodyMedium.copyWith(
                          color: AppColors.content_secondary,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    /// --- Account Alias (Name)
                    TextInputWidget(
                      title: "account_name".tr,
                      appTextField: AppTextField(
                        controller: controller.aliasController,
                        hintText: "enter_account_alias_hint".tr,
                        validator: InputValidators.combine([notEmptyValidator]),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    controller.isleanEnable == true
                        ? const SizedBox()
                        : SizedBox(height: 18.h),

                    /// --- Bank Dropdown
                    controller.isleanEnable == true
                        ? const SizedBox()
                        : GenericDropdown<GenericListModel>(
                      title: "bank".tr,
                      hint_text: "select_bank_hint".tr,
                      items: controller.listBanks ?? [],
                      initialValue: controller.selectedBank,
                      onChanged: (bank) {
                        controller.onBankSelected(bank);
                        controller.validateForm();
                      },
                      displayItemBuilder: (item) => Text(
                        item.name ?? "",
                        style: typography.bodyMedium.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),

                    /// --- Account Number
                    TextInputWidget(
                      title: "bank_account_number".tr,
                      appTextField: AppTextField(
                        controller: controller.accountNumberController,
                        hintText: "enter_bank_account_hint".tr,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validateBankAccountNumber,
                        ]),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 18.h),

                    /// --- IBAN
                    TextInputWidget(
                      title: "iban_number".tr,
                      appTextField: AppTextField(
                        controller: controller.ibanController,
                        hintText: "enter_iban_hint".tr,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validateSaudiIban,
                        ]),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    /// --- Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: PrimaryTextButton(
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigator.pop(context);
                            _openAddressSelectionBottomSheet(
                              context,
                              controller,
                            );
                          }
                        },
                        elevation: 0,
                        appButtonSize: AppButtonSize.xxLarge,
                        customBackgroundColor: AppColors.action_primary_normal,
                        label: Text(
                          "continue".tr,
                          style: typography.bodyStrongLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    /// --- Cancel Button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: PrimaryTextButton(
                        onTap: () => Navigator.pop(context),
                        appButtonSize: AppButtonSize.xxLarge,
                        customBackgroundColor: AppColors.white,
                        customBorder: BorderSide(
                          width: 1,
                          color: AppColors.border_default,
                        ),
                        label: Text(
                          "cancel".tr,
                          style: typography.bodyStrongLarge.copyWith(
                            color: AppColors.errorForeground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔹 Opens the next bottom sheet (address selector)
  void _openAddressSelectionBottomSheet(
      BuildContext context,
      StoreBankController controller,
      ) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      elevation: 1,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectAddressBottomSheet(controller: controller),
    );
  }
}
