import '../../../../index/index_main.dart';

class SubscribeSection extends StatefulWidget {
  final OpportunityDetailsController controller;
  final String? opportunityId;
  final TextEditingController textController;

  const SubscribeSection({
    super.key,
    required this.controller,
    required this.opportunityId,
    required this.textController,
  });

  @override
  State<SubscribeSection> createState() => _SubscribeSectionState();
}

class _SubscribeSectionState extends State<SubscribeSection> {
  bool isInputValid = false;

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final text = widget.textController.text.trim();
    final parsedValue = num.tryParse(text);
    final isNotEmpty = text.isNotEmpty;
    final isUnderLimit = _isUnderInvestmentLimit(parsedValue);
    final isAboveMin = _isAboveSharePrice(parsedValue);
    final isMultiple = _isMultipleOfSharePrice(parsedValue);
    final notOwner =
        !(widget.controller.opportunitiesItemsEntity?.isOwner ?? false);

    final newState =
        isNotEmpty && isUnderLimit && isAboveMin && isMultiple && notOwner;

    if (newState != isInputValid) {
      setState(() => isInputValid = newState);
    }
  }

  bool _isAboveSharePrice(num? value) {
    final minValue = widget.controller.opportunitiesItemsEntity?.sharePrice;
    return (value != null && minValue != null) ? value >= minValue : false;
  }

  bool _isUnderInvestmentLimit(num? value) {
    final limitation =
        widget.controller.opportunityDetailsEntity?.investmentLimitation;
    if (limitation?.limitation == true && value != null) {
      return value <= (limitation?.maxAmountCanInvest ?? double.infinity);
    }
    return true;
  }

  @override
  void dispose() {
    widget.textController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSubscribed =
        widget.controller.opportunitiesItemsEntity?.subscribed == true;
    final isOwner = widget.controller.opportunitiesItemsEntity?.isOwner == true;

    if (isOwner) {
      return Padding(
        padding: EdgeInsets.all(16.h),
        child: Text(
          "owner_investment_restriction".tr,
          style: context.typography.bodyMedium.copyWith(
            color: AppColors.errorForeground,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return isSubscribed
        ? _alreadySubscribed(context)
        : _subscribeInput(context);
  }

  /// ✅ Subscribed (Already Invested)
  Widget _alreadySubscribed(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
      decoration: BoxDecoration(
        color: AppColors.background_Neutral_Subtle,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border_Neutral_Subtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(IconsConstants.right_icon),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "already_invested_title".tr,
                  style: context.typography.bodyStrongMedium.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
              ),
              Text(
                "already_invested_description".tr,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
              ),
            ],
          ),

          /// 🔹 Buttons
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 55.h,
                  width: ScreenUtil().screenWidth,
                  child: PrimaryTextButton(
                    customBackgroundColor: AppColors.white,
                    customBorder: const BorderSide(
                      color: AppColors.border_natural_normal,
                      width: 1,
                    ),
                    label: Text(
                      "cancel_investment".tr,
                      style: context.typography.bodyMedium.copyWith(
                        color: AppColors.tertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () {
                      showCancelConfirmationDialog(
                        context,
                        onConfirm: () {
                          widget.textController.clear();
                          widget.controller.cancelSubscription(
                            widget.opportunityId ?? "",
                          );
                        },
                      );
                    },
                    appButtonSize: AppButtonSize.xxLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Input + Invest Button
  Widget _subscribeInput(BuildContext context) {
    final sharePrice = widget.controller.opportunitiesItemsEntity?.sharePrice;

    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Input Field
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border_natural_normal),
            ),
            child: TextField(
              controller: widget.textController,
              onChanged: (_) => _onTextChanged(),
              textAlign: TextAlign.right,
              style: context.typography.bodyMedium.copyWith(
                color: AppColors.darkJungleGreen,
              ),
              decoration: InputDecoration(
                hintText: "enter_investment_amount".tr,
                hintStyle: context.typography.bodyMedium.copyWith(
                  color: AppColors.tertiary,
                ),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),

          SizedBox(height: 14.h),

          /// Invest Button
          SizedBox(
            width: ScreenUtil().screenWidth,
            height: 55.h,
            child: PrimaryTextButton(
              label: Text(
                "invest".tr,
                style: context.typography.bodyStrongLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
              onTap: isInputValid
                  ? () {
                      final token = LoginResponseModel()
                          .getTokenData()
                          ?.data
                          ?.accessToken;
                      if (token == null) {
                        CheckGuestUser().openGuestUserBottomSheet(
                          "login_first".tr,
                        );
                      } else {
                        showRiskDisclaimerBottomSheet(
                          context,
                          opportunityId: widget.opportunityId,
                          controller: widget.controller,
                          textController: widget.textController.text,
                        );
                      }
                    }
                  : null,
              appButtonSize: AppButtonSize.xxLarge,
            ),
          ),

          /// Minimum investment note
          if (sharePrice != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "${'minimum_investment'.tr} ${sharePrice.toInt()} ${'riyal'.tr}",
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.tertiary,
                ),
              ),
            ),

          if (widget.textController.text.isNotEmpty &&
              !_isMultipleOfSharePrice(
                  num.tryParse(widget.textController.text)))
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                "المبلغ يجب أن يكون مضاعفات ${sharePrice?.toInt()}",
                style: context.typography.bodySmall.copyWith(
                  color: AppColors.errorForeground,
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool _isMultipleOfSharePrice(num? value) {
    final sharePrice = widget.controller.opportunitiesItemsEntity?.sharePrice;
    if (value == null || sharePrice == null) return false;

    // التأكد إنه مضاعف
    return value % sharePrice == 0;
  }
}
