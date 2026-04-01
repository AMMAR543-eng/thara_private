import 'package:thara/Presentation/design_systems/widgets/check_box/selectable_card_check_box_widget.dart';
import 'package:thara/Presentation/design_systems/widgets/check_box/selectable_widget_with_check_box_.dart';
import '../../../../../index/index_main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: GenericLanguageAppBar(title: "register_title".tr),
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Form(
              key: controller.registerFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- نوع المسجل (فرد / شركة)
                  SelectableWidgetWithCheckBox(
                    title: "register_type".tr,
                    options: controller.listTypes.map((type) {
                      return SelectableCardCheckBoxWidget(
                        title: type.id == 1 ? "individual".tr : "company".tr,
                        iconPath: type.id == 1
                            ? IconsConstants.person
                            : IconsConstants.company,
                        isSelected: controller.selectedType?.id == type.id,
                        onTap: () => controller.onTypeSelected(type),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 20.h),

                  /// --- Email
                  TextInputWidget(
                    title: "register_email".tr,
                    appTextField: AppTextField(
                      controller: controller.emailController,
                      hintText: "register_email_hint".tr,
                      validator: InputValidators.combine([
                        notEmptyValidator,
                        InputValidators.validateEmail,
                      ]),
                      onValidationChanged: (value) {
                        controller.setValidation(email: value);
                        controller.update();
                      },
                      keyboardType: TextInputType.emailAddress,
                      focusNode: FocusNode(),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  /// --- Password
                  TextInputWidget(
                    title: "register_password".tr,
                    appTextField: AppTextField(
                      controller: controller.passwordController,
                      hintText: "register_password_hint".tr,
                      validator: InputValidators.combine([
                        notEmptyValidator,
                        InputValidators.validatePassword,
                      ]),
                      onValidationChanged: (value) =>
                          controller.updatePasswordValidation(value),
                      onChanged: (value) => controller.update(),
                      obscureText: !controller.showPassword,
                      keyboardType: TextInputType.visiblePassword,
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

                  SizedBox(height: 8.h),

                  /// --- Password Rules
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRuleText(
                        context,
                        "password_rule_uppercase".tr,
                        controller.passwordController.text.contains(
                          RegExp(r'[A-Z]'),
                        ),
                      ),
                      _buildRuleText(
                        context,
                        "password_rule_lowercase".tr,
                        controller.passwordController.text.contains(
                          RegExp(r'[a-z]'),
                        ),
                      ),
                      _buildRuleText(
                        context,
                        "password_rule_number".tr,
                        controller.passwordController.text.contains(
                          RegExp(r'[0-9]'),
                        ),
                      ),
                      _buildRuleText(
                        context,
                        "password_rule_special_char".tr, // 👈 new rule
                        controller.passwordController.text.contains(
                          RegExp(r'[!@#\$%^&*(),.?":{}|<>]'),
                        ),
                      ),
                      _buildRuleText(
                        context,
                        "password_rule_length".tr,
                        controller.passwordController.text.length >= 8,
                      ),
                      _buildRuleText(
                        context,
                        "password_rule_no_spaces".tr,
                        !controller.passwordController.text.contains(" "),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  /// --- Confirm Password
                  TextInputWidget(
                    title: "register_confirm_password".tr,
                    appTextField: AppTextField(
                      controller: controller.confirmPasswordController,
                      hintText: "register_confirm_password_hint".tr,
                      obscureText: !controller.showConfirm,
                      onChanged: (value) => controller.update(),
                      validator: InputValidators.combine([
                        notEmptyValidator,
                        InputValidators.validatePassword,
                        (value) => InputValidators.validateConfirmationPassword(
                              value,
                              controller.passwordController.text,
                            ),
                      ]),
                      onValidationChanged: (value) {
                        controller.setValidation(confirm: value);
                        controller.update();
                      },
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: FocusNode(),
                      suffixIcon: InkWell(
                        onTap: controller.toggleConfirm,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            controller.showConfirm
                                ? IconsConstants.eye_off_icon
                                : IconsConstants.eye_icon,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// --- Terms & Conditions
                  Row(
                    children: [
                      Checkbox(
                        value: controller.check_terms,
                        onChanged: (val) {
                          controller.check_terms = val;
                          controller.update();
                        },
                        activeColor: AppColors.primary,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              RegisterTermsScreen(onPressed: () => Get.back()),
                            );
                          },
                          child: Text(
                            "register_terms".tr,
                            style: context.typography.bodyMedium.copyWith(
                              color: AppColors.textDefault,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// --- Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<RegisterController>(
                      id: 'auth_button',
                      builder: (controller) {
                        final enabled = controller.validEmail &&
                            controller.validPassword &&
                            controller.validConfirm &&
                            controller.check_terms == true &&
                            controller.selectedType != null;

                        return PrimaryTextButton(
                          label: Text(
                            "register_submit".tr,
                            style: context.typography.bodyLarge.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          onTap: enabled
                              ? () => controller.onSubmit(context)
                              : null,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// --- helper widget for password rules
  Widget _buildRuleText(BuildContext context, String text, bool passed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Icon(
            passed ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: passed
                ? AppColors.successForeground
                : AppColors.errorForeground,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: context.typography.bodySmall.copyWith(
              color: passed
                  ? AppColors.successForeground
                  : AppColors.errorForeground,
            ),
          ),
        ],
      ),
    );
  }
}
