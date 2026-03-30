import '../../../../index/index_main.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? code;

  const ResetPasswordScreen({super.key, this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const GenericLanguageAppBar(title: "forget_password_title"),

      body: GetBuilder<ForgetPasswordController>(
        init: ForgetPasswordController(),
        builder: (controller) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Form(
                key: controller.formResetKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Password
                    TextInputWidget(
                      title: "password".tr,
                      appTextField: AppTextField(
                        controller: controller.passwordController,
                        hintText: "password_hint".tr,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validatePassword,
                        ]),
                        onValidationChanged:
                        controller.updatePasswordValidation,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.showPassword,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SvgPicture.asset(
                            IconsConstants.locker,
                            color: AppColors.primary,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: controller.togglePasswordVisibility,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              controller.showPassword
                                  ? IconsConstants.eye_off_icon
                                  : IconsConstants.eye_icon,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),

                    /// Password Rules
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRule(context, "password_rule_upper".tr,
                            controller.hasUpperCase),
                        _buildRule(context, "password_rule_length".tr,
                            controller.hasMinLength),
                        _buildRule(context, "password_rule_lower".tr,
                            controller.hasLowerCase),
                        _buildRule(context, "password_rule_number".tr,
                            controller.hasNumber),
                        _buildRule(context, "password_rule_spaces".tr,
                            controller.noSpaces),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    /// Confirm Password
                    TextInputWidget(
                      title: "confirm_password".tr,
                      appTextField: AppTextField(
                        controller: controller.confirmPasswordController,
                        hintText: "confirm_password_hint".tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "confirm_password_required".tr;
                          }
                          if (value != controller.passwordController.text) {
                            return "passwords_not_match".tr;
                          }
                          return null;
                        },
                        onChanged: controller.updateConfirmPasswordValidation,
                        obscureText: !controller.showPasswordConfirm,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SvgPicture.asset(
                            IconsConstants.locker,
                            color: AppColors.primary,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: InkWell(
                          onTap: controller.toggleConfirmPasswordVisibility,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              controller.showPasswordConfirm
                                  ? IconsConstants.eye_off_icon
                                  : IconsConstants.eye_icon,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    /// Next Button
                    SizedBox(
                      width: double.infinity,
                      child: PressScaleWrapper(
                        enabled: controller.canSubmitResetPass,
                        child: PrimaryTextButton(
                          label: Text(
                            "next".tr,
                            style: context.typography.bodyLarge.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          onTap: controller.canSubmitResetPass
                              ? () {
                            controller.resetPassword(
                              controller.emailController.text,
                              controller.idController.text,
                              code ?? "",
                              controller.passwordController.text,
                              controller.confirmPasswordController.text,
                            );
                          }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRule(BuildContext context, String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid
              ? AppColors.successForeground
              : AppColors.errorForeground,
          size: 18,
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: context.typography.bodyMedium.copyWith(
            color: isValid
                ? AppColors.successForeground
                : AppColors.errorForeground,
          ),
        ),
      ],
    );
  }
}
