import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../index/index_main.dart';

class WalletBalanceCard extends StatelessWidget {
  final String? balance;
  final VoidCallback onWithdrawTap;
  final VoidCallback? onDepositTap;

  const WalletBalanceCard({
    super.key,
    required this.balance,
    required this.onWithdrawTap,
    this.onDepositTap,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final formattedBalance = formatNumber(
      num.tryParse(balance ?? ""),
      decimals: 2,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 Title
          Text(
            "total_surplus_balance".tr,
            textAlign: TextAlign.center,
            style: typography.bodyStrongMedium.copyWith(
              color: AppColors.content_secondary,
            ),
          ),

          /// 🔹 Balance + Riyal icon
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: formattedBalance,
                    style: typography.header3xLarge.copyWith(
                      color: AppColors.content_primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: SvgPicture.asset(
                        IconsConstants.riyal,
                        height: 22.h,
                        width: 22.w,
                        colorFilter: ColorFilter.mode(
                          AppColors.content_primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🔹 Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// إضافة رصيد
              Expanded(
                flex: 2,
                child: PrimaryTextButton(
                  onTap: onDepositTap ?? () {},
                  elevation: 0,
                  customBorder: BorderSide(
                    color: AppColors.border_default,
                    width: 1,
                  ),
                  customBackgroundColor: AppColors.white,
                  label: Text(
                    "+  ${'add_balance_button'.tr}",
                    style: typography.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              (balance == null || balance == "0")
                  ? const SizedBox()
                  :
                    /// سحب الرصيد المتاح
                    Expanded(
                      flex: 3,
                      child: PrimaryTextButton(
                        onTap: onWithdrawTap,
                        elevation: 0,
                        customBorder: BorderSide(
                          color: AppColors.border_default,
                          width: 1,
                        ),
                        customBackgroundColor: AppColors.white,
                        label: Text(
                          "withdraw_available_balance".tr,
                          style: typography.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
