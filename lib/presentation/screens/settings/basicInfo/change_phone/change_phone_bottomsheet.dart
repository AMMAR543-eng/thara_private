import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara/index/index_main.dart';

class EditPhoneBottomSheet extends StatelessWidget {
  final Function(String newPhone) onConfirm;

  const EditPhoneBottomSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final TextEditingController phoneController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 20.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Handle Bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border_natural_normal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 24.h),

                /// Title
                Text(
                  "edit_phone_number".tr,
                  style: typography.header3xLarge.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
                SizedBox(height: 24.h),

                Align(
                  alignment: LocalStorage_language().read() == "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Text(
                    "new_phone_number".tr,
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.content_primary,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                /// Phone Input Field
                AppTextField(
                  controller: phoneController,
                  hintText: "enter_new_phone_number".tr,
                  keyboardType: TextInputType.phone,
                  validator: InputValidators.combine([
                    notEmptyValidator,
                    InputValidators.validateSaudiPhone,
                  ]),
                  onValidationChanged: (_) {},
                ),
                SizedBox(height: 30.h),

                /// Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryTextButton(
                    onTap: () {
                      final phone = phoneController.text.trim();
                      if (phone.isEmpty || phone.length < 9) {
                        Loader.showError("enter_valid_phone".tr);
                        return;
                      }
                      Navigator.pop(context);
                      onConfirm(phone);
                    },
                    appButtonSize: AppButtonSize.large,
                    label: Text(
                      "continue".tr,
                      style: typography.bodyLarge.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                /// Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryTextButton(
                    onTap: () => Navigator.pop(context),
                    customBackgroundColor: AppColors.white,
                    customBorder: const BorderSide(
                      color: AppColors.border_natural_normal,
                      width: 1,
                    ),
                    appButtonSize: AppButtonSize.large,
                    label: Text(
                      "cancel".tr,
                      style: typography.bodyLarge.copyWith(
                        color: AppColors.content_primary,
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
  }
}
