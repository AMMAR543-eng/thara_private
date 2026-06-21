import 'package:thara/index/index_main.dart';

class SettingsChangePassView extends StatefulWidget {
  const SettingsChangePassView({super.key});

  @override
  State<SettingsChangePassView> createState() => _SettingsChangePassViewState();
}

class _SettingsChangePassViewState extends State<SettingsChangePassView> {
  late GenericKeyboardManager<String> keyboardManager;
  final formPasswordKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  bool showOldPassword = false;
  bool showPassword = false;
  bool showConfirm = false;

  @override
  void initState() {
    keyboardManager = GenericKeyboardManager<String>(nodeCount: 3);
    super.initState();
  }

  @override
  void dispose() {
    keyboardManager.dispose();
    oldPasswordController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: InnerViewAppBar(title: "change_password".tr),
      body: GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) {
          final user = controller.userInfoModel?.personalInfo;
          final account = controller.profileData?.account;

          return SafeArea(
            child: Form(
              key: formPasswordKey,
              child: KeyboardActions(
                config: keyboardManager.buildConfig(),
                disableScroll: true,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 30.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// --- Profile Header
                      LoginResponseModel().getTokenData()?.data?.accessToken ==
                              null
                          ? const SizedBox()
                          : Center(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 130.w,
                                        height: 130.h,
                                        decoration: BoxDecoration(
                                          color: AppColors
                                              .grayLight, // optional background
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          // 👈 THIS is key
                                          child: _getProfileImage(controller),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    controller.userInfoModel?.personalInfo
                                            ?.fullNameAr ??
                                        "",
                                    style: context.typography.headerXLarge
                                        .copyWith(
                                      color: AppColors.content_primary,
                                    ),
                                  ),
                                  Text(
                                    controller.profileData?.account?.id ?? "",
                                    style: context.typography.bodyMedium
                                        .copyWith(color: AppColors.tertiary),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: 20.h),

                      /// --- Old Password Field
                      AuthTextForm(
                        hint: "current_password".tr,
                        controller: oldPasswordController,
                        obscureText: !showOldPassword,
                        keyboardType: TextInputType.visiblePassword,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          InputValidators.validatePassword,
                        ]),
                        focusNode: keyboardManager.getFocusNode(0),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => showOldPassword = !showOldPassword,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: SvgPicture.asset(
                              showOldPassword
                                  ? IconsConstants.eye_off_icon
                                  : IconsConstants.eye_icon,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      /// --- New Password Field
                      AuthTextForm(
                        hint: "new_password".tr,
                        controller: passwordController,
                        obscureText: !showPassword,
                        keyboardType: TextInputType.visiblePassword,
                        validator: InputValidators.combine([]),
                        focusNode: keyboardManager.getFocusNode(1),
                        suffixIcon: InkWell(
                          onTap: () =>
                              setState(() => showPassword = !showPassword),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: SvgPicture.asset(
                              showPassword
                                  ? IconsConstants.eye_off_icon
                                  : IconsConstants.eye_icon,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        onValidationChanged: (_) => setState(() {}),
                      ),

                      SizedBox(height: 10.h),

                      /// --- Password Rules
                      _PasswordRulesList(passwordController.text),
                      SizedBox(height: 20.h),

                      /// --- Confirm Password Field
                      AuthTextForm(
                        hint: "confirm_new_password".tr,
                        controller: passwordConfirmController,
                        obscureText: !showConfirm,
                        keyboardType: TextInputType.visiblePassword,
                        validator: InputValidators.combine([
                          notEmptyValidator,
                          (value) =>
                              InputValidators.validateConfirmationPassword(
                                value,
                                passwordController.text,
                              ),
                        ]),
                        focusNode: keyboardManager.getFocusNode(2),
                        suffixIcon: InkWell(
                          onTap: () =>
                              setState(() => showConfirm = !showConfirm),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: SvgPicture.asset(
                              showConfirm
                                  ? IconsConstants.eye_off_icon
                                  : IconsConstants.eye_icon,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),

                      /// --- Submit Button
                      PrimaryTextButton(
                        onTap: () {
                          if (formPasswordKey.currentState?.validate() ??
                              false) {
                            controller.changePasswordApi(
                              oldPasswordController.text,
                              passwordController.text,
                              passwordConfirmController.text,
                            );
                          }
                        },
                        appButtonSize: AppButtonSize.large,
                        label: Text(
                          "confirm_change_password".tr,
                          style: typography.bodyLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  CachedNetworkImage _getProfileImage(SettingController controller) {
    final photoUrl = controller.profileData?.account?.profilePhoto?.url;

    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: photoUrl,
        fit: BoxFit.cover,
        width: double.infinity.w,
        height: double.infinity.h,
      );
    }

    final altPhoto = controller.userInfoModel?.account?.profilePhoto?.url;
    if (altPhoto != null && altPhoto.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: altPhoto,
        fit: BoxFit.cover,
        width: double.infinity.w,
        height: double.infinity.h,
      );
    }

    return CachedNetworkImage(
      imageUrl: Strings.placeholder_image,
      fit: BoxFit.contain,
      width: double.infinity.w,
      height: double.infinity.h,
    );
  }
}

class _PasswordRulesList extends StatelessWidget {
  final String password;

  const _PasswordRulesList(this.password);

  bool _hasUppercase(String value) => value.contains(RegExp(r'[A-Z]'));

  bool _hasLowercase(String value) => value.contains(RegExp(r'[a-z]'));

  bool _hasNumber(String value) => value.contains(RegExp(r'[0-9]'));

  bool _hasNoSpaces(String value) => !value.contains(' ');

  bool _hasMinLength(String value) => value.length >= 12;

  @override
  Widget build(BuildContext context) {
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ruleItem(context, "rule_uppercase".tr, _hasUppercase(password)),
        _ruleItem(context, "rule_lowercase".tr, _hasLowercase(password)),
        _ruleItem(context, "rule_number".tr, _hasNumber(password)),
        _ruleItem(context, "rule_no_spaces".tr, _hasNoSpaces(password)),
        _ruleItem(context, "rule_min_length".tr, _hasMinLength(password)),
      ],
    );
  }

  Widget _ruleItem(BuildContext context, String text, bool isValid) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.error_outline,
            color: isValid
                ? AppColors.successForeground
                : AppColors.errorForeground,
            size: 18,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: context.typography.bodyMedium.copyWith(
              color: isValid
                  ? AppColors.content_positive_secondary
                  : AppColors.errorForeground,
            ),
          ),
        ],
      ),
    );
  }
}
