import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../index/index_main.dart';

void showCancelWithdrawBottomSheet({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final typography = context.typography;

      return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 🔹 Warning Icon
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.errorForeground,
                size: 48,
              ),
              SizedBox(height: 20.h),

              /// 🔹 Title
              Text(
                'confirm_cancel_withdrawal'.tr,
                textAlign: TextAlign.center,
                style: typography.headerXLarge.copyWith(
                  color: AppColors.content_primary,
                ),
              ),
              SizedBox(height: 12.h),

              /// 🔹 Description
              Text(
                'are_you_sure_you_want_to_cancel_this_withdrawal'.tr,
                textAlign: TextAlign.center,
                style: typography.bodyMedium.copyWith(
                  color: AppColors.textSecondaryParagraph,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 30.h),

              /// 🔹 Buttons
              Row(
                children: [
                  Expanded(
                    child: PrimaryTextButton(
                      onTap: () => Navigator.pop(context),
                      customBackgroundColor: AppColors.white,
                      customBorder: const BorderSide(
                        color: AppColors.border_natural_normal,
                        width: 1,
                      ),
                      label: Text(
                        'cancel'.tr,
                        style: typography.bodyStrongLarge.copyWith(
                          color: AppColors.content_primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: PrimaryTextButton(
                      onTap: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      customBackgroundColor: AppColors.errorForeground,
                      label: Text(
                        'confirm'.tr,
                        style: typography.bodyStrongLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
