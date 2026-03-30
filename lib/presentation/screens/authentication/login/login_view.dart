import '../../../../index/index_main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF002825),
          actions: [
            InkWell(
              onTap: () async {
                final controller = initUseCase(() => AppLanguage());
                final currentLang = LocalStorage_language().read();
                if (currentLang == 'ar') {
                  controller.changeLanguage('en');
                } else {
                  controller.changeLanguage('ar');
                }
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.language,
                  color: AppColors.white_dark,
                  size: 25,
                ),
              ),
            ),
          ],
        ),

        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        body: GetBuilder<LoginController>(
          init: LoginController(),
          builder: (controller) {
            return Stack(
              children: [
                /// 🔹 Gradient Background
                Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.onboardingBackground,
                  ),
                ),

                /// 🔹 Foreground Content (scrolls fully)
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      /// Top logo + image
                      SafeArea(
                        bottom: false,
                        child: SizedBox(
                          height: ScreenUtil().screenHeight * 0.35,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: SvgPicture.asset(
                                  IconsConstants.logo,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                              Image.asset(Images.login_image),
                            ],
                          ),
                        ),
                      ),

                      /// Form Card
                      Container(
                        width: double.infinity,
                        height: ScreenUtil().screenHeight * 0.65,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 24.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Form(
                          key: controller.formLoginKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Title
                              Center(
                                child: Text(
                                  "login_welcome_title".tr,
                                  style: context.typography.bodyStrongLarge
                                      .copyWith(
                                        color:
                                            AppColors.content_brand_secondary,
                                      ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Center(
                                child: Text(
                                  "login_welcome_subtitle".tr,
                                  style: context.typography.bodyLarge.copyWith(
                                    color: AppColors.content_secondary,
                                  ),
                                ),
                              ),

                              /// Email
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: TextInputWidget(
                                  title: "login_email_label".tr,
                                  appTextField: AppTextField(
                                    controller: controller.emailController,
                                    hintText: "login_email_hint".tr,
                                    validator: InputValidators.combine([
                                      notEmptyValidator,
                                      InputValidators.validateEmail,
                                    ]),
                                    onValidationChanged:
                                        controller.updateEmailValidation,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),

                              /// Password
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 10,
                                ),
                                child: TextInputWidget(
                                  title: "login_password_label".tr,

                                  appTextField: AppTextField(
                                    controller: controller.passwordController,
                                    hintText: "login_password_hint".tr,
                                    validator: InputValidators.combine([
                                      notEmptyValidator,
                                      //  InputValidators.validatePassword,
                                    ]),

                                    onValidationChanged:
                                        controller.updatePasswordValidation,
                                    obscureText: !controller.showPassword,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      child: SvgPicture.asset(
                                        IconsConstants.locker,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap:
                                          controller.togglePasswordVisibility,
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
                                    keyboardType: TextInputType.visiblePassword,
                                  ),
                                ),
                              ),

                              /// Forgot
                              GestureDetector(
                                onTap: controller.onForgotPassword,
                                child: Text(
                                  "login_forgot_password".tr,
                                  style: context.typography.bodyLarge.copyWith(
                                    color: AppColors.primary_normal,
                                  ),
                                ),
                              ),

                              /// Login Button
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 20.0.h,
                                        bottom: 10.h,
                                      ),
                                      child: PressScaleWrapper(
                                        enabled: controller.canLogin,
                                        child: PrimaryTextButton(
                                          label: Text(
                                            "login_button".tr,
                                            style: context.typography.bodyLarge,
                                          ),
                                          onTap: controller.canLogin
                                              ? () =>
                                                    controller.onLogin(context)
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  UserModel().getUserData()?.email != null &&
                                          BioUserModel.getBioData()
                                                  ?.isBiometric ==
                                              true
                                      ? InkWell(
                                          onTap: () {
                                            final biometricVm = Get.put(
                                              BiometricLoginViewModel(),
                                            );
                                            biometricVm.checkBiometricAuth();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10.0,
                                            ),
                                            child: SvgPicture.asset(
                                              IconsConstants.fingerprint,
                                              // 👆 لازم تضيف الأيقونة هنا
                                              color: AppColors.primary,
                                              width: 40.w,
                                              height: 45.h,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),

                              /// Create Account
                              SizedBox(
                                width: ScreenUtil().screenWidth,
                                child: PrimaryTextButton(
                                  onTap: controller.onCreateAccount,
                                  customBackgroundColor: AppColors.white,
                                  customBorder: BorderSide(
                                    color: AppColors.action_natural_normal,
                                    width: 0.2,
                                  ),
                                  label: Text(
                                    "login_create_account".tr,
                                    style: context.typography.bodyMedium
                                        .copyWith(
                                          color:
                                              AppColors.action_natural_normal,
                                        ),
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  LoginResponseModel().deleteTokenLocal();
                                  const AccountModel().deleteAccountLocal();
                                  UserModel().deleteUserLocal();
                                  BioUserModel.deleteBioLocal();
                                  Get.offAllNamed(mainPage);
                                },
                                child: SizedBox(
                                  height: 50.h,
                                  width: ScreenUtil().screenWidth,
                                  child: Center(
                                    child: Text(
                                      "login_guest".tr,
                                      textAlign: TextAlign.center,

                                      style: context.typography.bodyLarge
                                          .copyWith(
                                            color: AppColors.primary_normal,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
