import 'package:thara/Domain/parameters/auth/register_param.dart';
import 'package:thara/Presentation/screens/authentication/update_password/udpate_password_controller.dart';

import '../../../../index/index_main.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  dynamic argumentData = Get.arguments;
  late GenericKeyboardManager<String> keyboardManager;
  final formResetKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showPassword = false;
  bool showConfirm = false;
  bool validPassword = false;
  bool validConfirm = false;

  @override
  void initState() {
    keyboardManager = GenericKeyboardManager<String>(nodeCount: 2);
    super.initState();
  }

  @override
  void dispose() {
    keyboardManager.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003B3A),
      body: GetBuilder<UpdatePasswordController>(
        init: UpdatePasswordController(),
        builder: (controller) {
          return KeyboardActions(
            config: keyboardManager.buildConfig(),
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF003B3A), Colors.black],
                      ),
                    ),
                    child: const Center(heightFactor: 4, child: LogoWidget()),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(128),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Form(
                      key: formResetKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                AuthTitleWidget(title: "كلمة السر الجديدة".tr),
                                const Spacer(),
                                const BackButtonWidget(),
                              ],
                            ),
                            SizedBox(height: 60.h),
                            AuthTextForm(
                              hint: "كلمة السر".tr,
                              controller: passwordController,
                              obscureText: showPassword,
                              keyboardType: TextInputType.visiblePassword,
                              validator: InputValidators.combine([
                                notEmptyValidator,
                                InputValidators.validatePassword,
                              ]),
                              focusNode: keyboardManager.getFocusNode(0),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => showPassword = !showPassword,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    showPassword
                                        ? IconsConstants.hidePassword
                                        : IconsConstants.eye,
                                    color: AppColors.darkGray,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              onValidationChanged: (v) =>
                                  setState(() => validPassword = v),
                            ),
                            SizedBox(height: 40.h),
                            AuthTextForm(
                              hint: "التحقق من كلمة السر".tr,
                              controller: confirmPasswordController,
                              obscureText: showConfirm,
                              keyboardType: TextInputType.visiblePassword,
                              validator: InputValidators.combine([
                                notEmptyValidator,
                                InputValidators.validatePassword,
                                (value) =>
                                    InputValidators.validateConfirmationPassword(
                                      value,
                                      passwordController.text,
                                    ),
                              ]),
                              focusNode: keyboardManager.getFocusNode(1),
                              suffixIcon: InkWell(
                                onTap: () =>
                                    setState(() => showConfirm = !showConfirm),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                  ),
                                  child: SvgPicture.asset(
                                    showConfirm
                                        ? IconsConstants.hidePassword
                                        : IconsConstants.eye,
                                    color: AppColors.darkGray,
                                  ),
                                ),
                              ),
                              onValidationChanged: (v) =>
                                  setState(() => validConfirm = v),
                            ),
                            SizedBox(height: 20.h),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AuthButtonWidget(
                                    title: "تأكيد".tr,
                                    next: true,
                                    onPressed: (validPassword && validConfirm)
                                        ? () {
                                            if (formResetKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              controller.updatePassword(
                                                param: SignUpParam(
                                                  password:
                                                      passwordController.text,
                                                  passwordConfirm:
                                                      confirmPasswordController
                                                          .text,
                                                ),
                                              );
                                            }
                                          }
                                        : null,
                                  ),
                                  SizedBox(height: 140.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
