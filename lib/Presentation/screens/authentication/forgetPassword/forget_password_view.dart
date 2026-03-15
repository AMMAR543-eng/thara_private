import '../../../../index/index_main.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
                key: controller.formForgetKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Text(
                      "forget_password_section_title".tr,
                      style: context.typography.headerXLarge.copyWith(
                        color: AppColors.content_brand_secondary,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Email
                    TextInputWidget(
                      title: "email".tr,
                      appTextField: AppTextField(
                        controller: controller.emailController,
                        hintText: "email_hint".tr,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validateEmail,
                        ]),
                        onValidationChanged: controller.updateEmailValidation,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    // National ID
                    TextInputWidget(
                      title: "national_id".tr,
                      appTextField: AppTextField(
                        controller: controller.idController,
                        hintText: "national_id_hint".tr,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validateIdentityNumber,
                        ]),
                        onValidationChanged: controller.updateIdValidation,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    const Spacer(),

                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      child: PressScaleWrapper(
                        enabled: controller.canSubmit,
                        child: PrimaryTextButton(
                          label: Text(
                            "next".tr,
                            style: context.typography.bodyLarge.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          onTap: controller.canSubmit
                              ? () {
                                  controller.initialResetPassword(
                                    controller.emailController.text,
                                    controller.idController.text,
                                    context,
                                  );
                                  // show otp code bottom sheet
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
}
