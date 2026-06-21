import 'dart:ui';

import '../../../../../index/index_main.dart';

class DepositMethodBottomSheet extends StatelessWidget {
  const DepositMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: [
              /// --- Handle
              Container(
                width: 60.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                  color: AppColors.border_natural_normal,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),

              /// --- Title
              Text(
                "choose_deposit_method".tr,
                style: context.typography.headerXLarge.copyWith(
                  color: AppColors.content_brand_secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),

              /// --- Subtitle
              Text(
                "investment_note".tr,
                style: context.typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),

              /// --- Payment Options
              _PaymentOptionCard(
                icon: Icons.account_balance,
                title: "bank_transfer".tr,
                onTap: () {
                  Get.back();
                  Get.to(
                    () => const BankTransferView(),
                    binding: Binding(),
                    duration: const Duration(milliseconds: 0),
                  );
                },
              ),
              // SizedBox(height: 14.h),
              //
              // _PaymentOptionCard(
              //   iconWidget: Image.asset(Images.apple_pay, height: 40.h),
              //   title: "apple_pay".tr,
              //   onTap: () async {
              //     Get.back();
              //     await showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       backgroundColor: Colors.transparent,
              //       builder: (context) => const ApplePayBottomSheet(),
              //     );
              //   },
              // ),

              SizedBox(height: 30.h),

              /// --- Close Button
              SizedBox(
                width: double.infinity,
                child: PrimaryTextButton(
                  label: Text(
                    "close".tr,
                    style: context.typography.bodyLarge.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  onTap: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// --- Payment Option Card (Thara Consistent)
class _PaymentOptionCard extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final String title;
  final VoidCallback? onTap;

  const _PaymentOptionCard({
    this.icon,
    this.iconWidget,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.grayMedium, width: 1),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            iconWidget ?? Icon(icon, color: AppColors.primary, size: 28),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: context.typography.bodyLarge.copyWith(
                  color: AppColors.content_primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.grayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
