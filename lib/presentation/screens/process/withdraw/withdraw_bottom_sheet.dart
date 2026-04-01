import '../../../../../../index/index_main.dart';

class WithdrawBottomSheet extends StatefulWidget {
  final List<GenericListModel> bankAccounts;

  const WithdrawBottomSheet({Key? key, required this.bankAccounts})
      : super(key: key);

  @override
  State<WithdrawBottomSheet> createState() => _WithdrawBottomSheetState();
}

class _WithdrawBottomSheetState extends State<WithdrawBottomSheet> {
  final TextEditingController withdrawNumberController =
      TextEditingController();
  GenericListModel? selectedBank;
  bool _isFilterActive = false;
  late GenericKeyboardManager<String> keyboardManager;

  @override
  void initState() {
    super.initState();
    keyboardManager = GenericKeyboardManager<String>(nodeCount: 1);
    withdrawNumberController.addListener(_updateFilterButtonState);
  }

  void _updateFilterButtonState() {
    final hasSelectedBank = selectedBank != null;
    final hasWithdrawValue = withdrawNumberController.text.trim().isNotEmpty;
    setState(() => _isFilterActive = hasSelectedBank && hasWithdrawValue);
  }

  @override
  void dispose() {
    keyboardManager.dispose();
    withdrawNumberController.dispose();
    super.dispose();
  }

  Future<void> applyWithdraw() async {
    final value = withdrawNumberController.text;
    final withdrawValue = double.tryParse(value) ?? 0;

    ProcessService().storeWithdraw(
      params: CancelWithdrawParams(
        amount: withdrawValue.toString(),
        bankAccountId: selectedBank?.id ?? 0,
      ),
      voidCallBack: (data) async {
        Get.back();
        await showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: true,
          elevation: 1,
          backgroundColor: Colors.transparent,
          builder: (context) => OtpView(
            title: "verification".tr,
            desc: "otp_sent_to_Email".tr,
            withdrawId: data.data?.withdrawalRequest?.id,
            phone: LoginResponseModel().getTokenData()?.user?.phoneNumber ?? "",
            page: OtpPages.withdraw,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Handle
              Container(
                width: 60.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                  color: AppColors.border_natural_normal,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              /// Title
              Text(
                "withdraw_from_balance".tr,
                style: typography.headerXLarge.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
                textAlign: TextAlign.center,
              ),

              /// Amount Input
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                margin: EdgeInsets.only(top: 15.h, bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconsConstants.riyal,
                      width: 22.w,
                      color: AppColors.content_primary,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: withdrawNumberController,
                        textAlign: TextAlign.center,
                        style: typography.header2xLarge.copyWith(
                          color: AppColors.content_primary,
                        ),
                        decoration: InputDecoration(
                          hintText: "0.00",
                          hintStyle: typography.bodyStrongLarge.copyWith(
                            color: AppColors.textSecondaryParagraph,
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "transfer_amount".tr,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
              ),
              SizedBox(height: 15.h),

              /// Bank Dropdown
              GenericDropdown<GenericListModel>(
                title: "transfer_to".tr,
                hint_text: "select_bank_account".tr,
                items: widget.bankAccounts,
                initialValue: selectedBank,
                onChanged: (val) {
                  setState(() => selectedBank = val);
                  _updateFilterButtonState();
                },
                displayItemBuilder: (item) => Text(
                  item.text ?? "",
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
              ),

              /// Summary Section
              Padding(
                padding: EdgeInsets.only(top: 24.0.h, bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "total_transfer_fees".tr,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.content_secondary,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "0.00 ",
                          style: typography.bodyStrongLarge.copyWith(
                            color: AppColors.textSecondaryParagraph,
                          ),
                        ),
                        SvgPicture.asset(
                          IconsConstants.riyal,
                          height: 20.h,
                          width: 20.w,
                          color: AppColors.content_primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 30.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "total_deducted_amount".tr,
                      style: typography.bodyStrongMedium.copyWith(
                        color: AppColors.content_primary,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          withdrawNumberController.text.isEmpty
                              ? "0.00"
                              : withdrawNumberController.text,
                          style: typography.bodyStrongMedium.copyWith(
                            color: AppColors.content_primary,
                          ),
                        ),
                        SvgPicture.asset(
                          IconsConstants.riyal,
                          width: 16.w,
                          color: AppColors.content_primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Buttons
              SizedBox(
                height: 55.h,
                width: ScreenUtil().screenWidth,
                child: PrimaryTextButton(
                  onTap: _isFilterActive ? applyWithdraw : null,
                  appButtonSize: AppButtonSize.xxLarge,
                  customBackgroundColor: AppColors.action_primary_normal,
                  label: Text(
                    "next".tr,
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 55.h,
                width: ScreenUtil().screenWidth,
                child: PrimaryTextButton(
                  onTap: () => Get.back(),
                  appButtonSize: AppButtonSize.xxLarge,
                  customBackgroundColor: AppColors.white,
                  customBorder: const BorderSide(
                    width: 1,
                    color: AppColors.border_natural_normal,
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
    );
  }
}
