import 'package:thara/Presentation/screens/process/deposite/deposite_controller.dart';
import '../../../../index/index_main.dart';

class BankTransferView extends StatelessWidget {
  const BankTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "bank_transfer".tr,
          style: context.typography.bodyLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<DepositeController>(
          init: DepositeController(),
          builder: (controller) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// --- Bank Info Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: AppColors.border_natural_normal,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// --- Bank Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "anb_bank_name".tr,
                                  style: typography.bodyStrongLarge.copyWith(
                                    color: AppColors.content_brand_secondary,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  "fast_bank".tr,
                                  style: typography.bodyMedium.copyWith(
                                    color: AppColors.content_secondary,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              Images.anb,
                              height: 60.h,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),
                        const Divider(
                          thickness: 0.4,
                          color: AppColors.grayLight,
                        ),

                        /// --- Name
                        _BankDetailItem(
                          label: "name".tr,
                          value:
                              controller.baseEntity?.user?.name ?? "----------",
                          typography: typography,
                          showCopy: false,
                        ),

                        const Divider(thickness: 0.3),

                        /// --- IBAN
                        _BankDetailItem(
                          label: "iban".tr,
                          value:
                              controller
                                  .baseEntity
                                  ?.account
                                  ?.virtualAccount
                                  ?.iban ??
                              "----------",
                          typography: typography,
                        ),

                        const Divider(thickness: 0.3),

                        /// --- Account Number
                        _BankDetailItem(
                          label: "account_number".tr,
                          value:
                              controller
                                  .baseEntity
                                  ?.account
                                  ?.virtualAccount
                                  ?.accountNumber ??
                              "----------",
                          typography: typography,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),


                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// --- Reusable Bank Field Item
class _BankDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final AppTypography typography;
  final bool showCopy;

  const _BankDetailItem({
    required this.label,
    required this.value,
    required this.typography,
    this.showCopy = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label + Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.tertiary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: typography.bodyLarge.copyWith(
                    color: AppColors.content_primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// Copy Icon (if enabled)
          if (showCopy) SizedBox(width: 12.w),
          if (showCopy)
            InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("copied_to_clipboard".tr),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.primary,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child:  Icon(
                  Icons.copy_outlined,
                  size: 22,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
