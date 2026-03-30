import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thara/index/index_main.dart';

class EditEmailBottomSheet extends StatelessWidget {
  final Function(String newEmail) onConfirm;

  const EditEmailBottomSheet({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    final TextEditingController emailController = TextEditingController();

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
                /// --- Handle Bar
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.border_natural_normal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: 24.h),

                /// --- Title
                Text(
                  "edit_email_title".tr,
                  style: typography.header3xLarge.copyWith(
                    color: AppColors.content_primary,
                  ),
                ),
                SizedBox(height: 24.h),

                /// --- Label
                Align(
                  alignment:LocalStorage_language().read() == "ar" ? Alignment.centerRight: Alignment.centerLeft,
                  child: Text(
                    "new_email_label".tr,
                    style: typography.bodyStrongLarge.copyWith(
                      color: AppColors.content_primary,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                /// --- Input Field
                AppTextField(
                  controller: emailController,
                  hintText: "new_email_hint".tr,
                  keyboardType: TextInputType.emailAddress,
                  validator: InputValidators.combine([
                    notEmptyValidator,
                    InputValidators.validateEmail,
                  ]),
                  onValidationChanged: (_) {},
                ),

                SizedBox(height: 30.h),

                /// --- Confirm Button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryTextButton(
                    onTap: () {
                      final email = emailController.text.trim();
                      if (email.isEmpty || !email.contains('@')) {
                        Loader.showError("invalid_email_error".tr);
                        return;
                      }
                      Navigator.pop(context);
                      onConfirm(email);
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

                /// --- Cancel Button
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
