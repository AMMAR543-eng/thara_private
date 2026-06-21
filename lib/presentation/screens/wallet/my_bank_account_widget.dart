import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../index/index_main.dart';

class DetailedBankCardWidget extends StatelessWidget {
  final String bankName;
  final String ownerName;
  final String iban;
  final String accountNumber;
  final String logoPath;
  final bool isPrimary;
  final VoidCallback? onCopyIban;
  final VoidCallback? onCopyAccount;

  const DetailedBankCardWidget({
    super.key,
    required this.bankName,
    required this.ownerName,
    required this.iban,
    required this.accountNumber,
    required this.logoPath,
    this.isPrimary = false,
    this.onCopyIban,
    this.onCopyAccount,
  });

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border_default),
        boxShadow: [
          BoxShadow(
            color: AppColors.border_default.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header
          Row(
            children: [
              /// Bank Logo
              SizedBox(
                height: 60.w,
                width: 60.h,
                child: Image.asset(Images.anb),
              ),
              SizedBox(width: 5.w),

              /// Account title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPrimary
                        ? "primary_account".tr
                        : "alternate_account_name".tr,
                    style: typography.bodyMedium.copyWith(
                      color: AppColors.content_secondary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    bankName,
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.content_primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 8),
            child: Divider(color: AppColors.border_default, thickness: 1),
          ),

          /// 🔹 Account Owner
          _buildCopyRow(
            context,
            label: "account_owner_name".tr,
            show_copy: false,
            value: ownerName,
            typography: typography,
          ),
          SizedBox(height: 10.h),

          /// 🔹 IBAN
          _buildCopyRow(
            context,
            label: "iban".tr,
            value: iban,
            typography: typography,
            onCopy: onCopyIban,
          ),
          SizedBox(height: 10.h),

          /// 🔹 Account number
          _buildCopyRow(
            context,
            label: "account_number".tr,
            value: accountNumber,
            typography: typography,
            onCopy: onCopyAccount,
          ),
          SizedBox(height: 12.h),

          /// 🔹 Note section
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 6.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "transfer_note_title".tr,
                      style: typography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  "transfer_note_description".tr,
                  style: typography.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔸 Helper — Label, Value + Copy Button
  Widget _buildCopyRow(
    BuildContext context, {
    required String label,
    required String value,
    bool? show_copy,
    required AppTypography typography,
    VoidCallback? onCopy,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.content_secondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                textAlign: TextAlign.left,
                style: typography.bodyStrongLarge.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        show_copy != null
            ? const SizedBox()
            : InkWell(
                onTap: onCopy,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border_default),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.copy,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
      ],
    );
  }
}
